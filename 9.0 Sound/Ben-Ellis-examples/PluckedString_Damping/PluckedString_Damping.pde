/*
 * PluckedString+Damping
 *
 * Simulate a plucked string via digital waveguides.
 * Set the "length" of the string via the f0 constant below.
 * Clicking on the string "plucks" it at that point; 
 * move the mouse up/down (while clicking) to make a sharper 
 * or rounder plucked displacement; release to set the 
 * string ringing.
 * White trace shows the computed displacement of the 
 * entire string; blue and red curves above and below 
 * show the two underlying traveling waves.
 *
 * Shift-click to "damp" a plucked string at different points, 
 * closer to the bottom of the window for more damping.
 * With a little care, you can use this to get harmonics.
 *
 * 2010-01-24 Dan Ellis dpwe@ee.columbia.edu
 */

import ddf.minim.*;

Minim minim;
AudioOutput out;
PluckedString string;

// The fundamental frequency of the string (in Hz)
// Setting this very low (e.g. 2.0) results in 
// visible traveling waves.
float f0 = 440.0;

void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);

  // initialize the string (but it won't ring until you pluck it)  
  string = new PluckedString(f0, 1.0);
}

void mousePressed()
{
  mouseDragged();
}

void mouseDragged()
{
  // map the mouse position to pluck point and amplitude
  float pluck_point = map(mouseX, 0, width, 0, 1);
  if (keyPressed == false) {
    // click with no key down is pluck
    float sharpness = map(mouseY, 0, height, 0, 1);
    string.pluck(pluck_point, sharpness);
  } else {
    // click with key is damping
    float reflec_k = map(mouseY, 0, height, -1, 1);
    if (reflec_k > 1.0)  reflec_k = 1.0;
    string.setDamp(pluck_point, reflec_k);
  }
}

void mouseReleased()
{
  if (keyPressed == false) {
    // start the string sounding
    string.release();
  } else {
    // undo damping - damp point of zero means no damping
    string.setDamp(0.0, 1.0);
  }
}

void draw()
{
  // pass this on to the string object to draw itself
  string.draw();
}

void stop()
{
  // always close minim before stopping
  out.close();
  minim.stop();
 
  super.stop();
}

// The PluckedString class implements a single digital waveguide 
// of a specific length to simulate a string

class PluckedString implements AudioSignal
{
  int wg_length;     // the length of the string in samples
  float[] y_plus;    // buffer to hold positive-moving wave
  float[] y_minus;   // buffer to hold negative-moving wave
  float[] y;         // temporary buffer to calculate resultant shape of wave, used during display

  float[] reflec_filt  = {.25, .5, .25};  // the dispersion filter at the "bridge" end reflection
  int ref_hlen;
  boolean active;    // flag to stop the wave from propagating while string is being plucked
  
  // variables to control interactive damping (experimental)
  float damp_point;
  float damp_r;

  PluckedString(float freq, float ampl)
  {
    // Waveguide length is a delay equivalent to half the desired period
    wg_length = Math.round(out.sampleRate()/freq/2);
    // how much extra to allow for reflection filter
    ref_hlen = (reflec_filt.length-1)/2;
    y_plus = new float[wg_length+ref_hlen]; // extra for symmetric ref_filt
    y_minus = new float[wg_length+ref_hlen];  // just convenience
    // combined wave used only for display
    y = new float[wg_length];

    // initialize damping point to 0.0, no effect
    damp_point = 0.0;
    damp_r = 1.0;
    
    // connect it to output for sound output
    out.addSignal(this);
  }
  
  // PluckedString::pluck is called to setup an initial displacement of the string
  // It stops the string from ringing, call PluckedString::release to start it again.
  void pluck(float pluck_point, float sharpness)
  {
    // stop wave propagation for a moment
    active = false;
    // remove damping
    damp_point = 0.0;
        
    // initialize traveling wave values in response to pluck
    // equal and triangular, for string displaced at pluck_point of its length
    // raise triangular waveshape to a positive exponent to allow more sharper plucks
    float exponent = (float)Math.pow(2.0, 8*sharpness);
    float pluck_amp = 1.0;
    for (int i = 0; i < wg_length; ++i) {
      if (i < Math.round(pluck_point * (float)wg_length)) {
        y_minus[i] = y_plus[i] = (float)Math.pow(pluck_amp*(float)i/(pluck_point*(float)wg_length), exponent);
      } else {
        y_minus[i] = y_plus[i] = (float)Math.pow(pluck_amp*(float)(wg_length-i)/((1-pluck_point)*(float)wg_length), exponent);
      }
    }
  }
  
  // called after setting up waveshape with pluck() to start oscillation
  void release() {
    active = true;
  }
  
  // external control for the experimental damping function
  void setDamp(float position, float ratio)
  {
    damp_point = position;
    // ratio comes in as -1..1
    //damp_r = ratio;
    damp_r = (float)Math.pow(2.0, 5*(-1.0-ratio));  // 0.001 .. 1.0
    println("damp_r="+damp_r);
  }

  // helper function draws a waveshape in a specific box and color
  void drawWave(float [] vals, int len, int x, int y, int w, int h, int r, int g, int b)
  {
    stroke(r,g,b);
    int mid = y + h/2;
    int vscale = h/2;
    for(int i = 0; i < len-1; i++)
    {
      float x1 = x+map(i, 0, len, 0, w);
      float x2 = x+map(i+1, 0, len, 0, w);
      line(x1, mid - vscale*vals[i],
             x2, mid - vscale*vals[i+1]); 
    }
  }

  // display the current state of the string  
  void draw()
  {
    background(0);
    stroke(255);
    // draw the two traveling waves and their sum = string displacement
    // forward wave in red, top half of pane
    drawWave(y_plus, wg_length, 0, height/2, width, height/2, 255,0,0);
    // backward wave in blue, bottom half of pane
    drawWave(y_minus, wg_length, 0, 0, width, height/2, 0,0,255);
    // combined wave - white, middle of pane
    // sum up the two traveling waves
    for (int i = 0; i < wg_length; ++i)
    {
      y[i] = y_plus[i] + y_minus[i];
    }
    drawWave(y, wg_length, 0, height/4, width, height/2, 255,255,255);
    if (damp_point > 0) {
      stroke(255);
      int damp_x = Math.round(map(damp_point, 0, 1, 0, width));
      line(damp_x,0,damp_x,height);
    }
  }
  
  // called by sound output to calculate samples, drives the basic 
  // computation loop.
  void generate(float[] samps)
  {
    // each sample of the output corresponds to one time step 
    // of the basic physics simulaiton
    for(int i = 0; i < samps.length; ++i) 
    {
      float y_reflec = 0;
      // only do anything if the string has been released
      if (active == true)
      {
        // move the traveling waves one point forward
        for (int j = y_plus.length-1; j > 0; --j)  {
          // copy forward starting at end
          y_plus[j] = y_plus[j-1];
        }
        for (int j = 0; j < y_plus.length-1; ++j) 
        {
          // copy backwards starting at beginning
          y_minus[j] = y_minus[j+1];
        }
        // simple reflection at one end
        y_plus[0] = -y_minus[0];
        // filtered reflection at far end
        for (int k=0; k < reflec_filt.length; ++k)
        {
          // y_plus has a few points "off the end" to allow 
          // a symmetric reflec_filter
          y_reflec += reflec_filt[k] * y_plus[wg_length - 1 - ref_hlen + k];
        }
        // reflected wave is the new point in the backward-traveling wave
        y_minus[wg_length - 1] = -y_reflec;
        
        // apply experimental damping/scattering
        int damp_index = Math.round(damp_point * wg_length);
        if (damp_index > 0)
        {
          // additional offsets to traveling wave both ways
          float y0 = y_plus[damp_index] + y_minus[damp_index];
          if (y0 > damp_r) {
            float delta = y0 - damp_r;
            // add to ongoing waves
            y_plus[damp_index] -= delta;
            y_minus[damp_index] -= delta;
          }
        }
      }
      // output is given by amount of reflection (~ energy being passed through bridge)
      samps[i] = y_reflec;
    }
  }
  
  // AudioSignal requires both mono and stereo generate functions
  void generate(float [] sampL, float [] sampR)
  {
    generate(sampL);
    // copy left to right
    System.arraycopy(sampL, 0, sampR, 0, sampR.length);
  }
}