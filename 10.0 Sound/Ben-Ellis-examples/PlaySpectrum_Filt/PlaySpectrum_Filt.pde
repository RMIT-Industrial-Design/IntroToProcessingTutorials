/**
  * PlaySpectrum_filt
  *
  * Run an FFT on soundfile playback, and plot the spectrum in dB.
  * Includes a stage of filtering with a directly-implemented 2 pole IIR filter.
  * Mouse x controls center frequency, y controls bandwidth (Q).
  *
  * Bandpass filter is implemented explicitly instead of using the minim
  * bpf class "for educational purposes".
  *
  * Based on http://processing.org/learning/libraries/forwardfft.html by ddf, 
  * and copies the idea of 
  * http://processing.org/learning/libraries/bandpassfilter.html by ddf.
  *
  * 2010-02-03 Dan Ellis dpwe@ee.columbia.edu
  */
 
import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;
AudioPlayer sound;
FFT fft;
Filter filter;

boolean paused = false;

// spectrum display configuration
int buffer_size = 2048;  // also sets FFT size (frequency resolution)
float gain = 40; // in dB
float dB_scale = 2.0;  // pixels per dB

int spectrum_height = 200; // determines range of dB shown
int legend_height = 20;
int spectrum_width = 512; // determines how much of spectrum we see
int legend_width = 50;

// filter properties
float centerFreq = 1000;
float bandwidth = 500;

void setup()
{
//  size(legend_width+spectrum_width, spectrum_height+legend_height, P2D);
  // size has to be explicit for the applet export to extract it correctly
  size(562, 220, P2D);
  textMode(SCREEN);
  textFont(createFont("SanSerif", 12));
 
  minim = new Minim(this);
 
  sound = minim.loadFile("sound.wav",buffer_size);
  // make it repeat
  sound.loop();
 
  // create an FFT object that has a time-domain buffer 
  // the same size as line-in's sample buffer
  fft = new FFT(sound.bufferSize(), sound.sampleRate());
  // Tapered window important for log-domain display
  fft.window(FFT.HAMMING);
  
  // create a filter and insert it
  filter = new Filter(centerFreq, bandwidth, sound.sampleRate());
  sound.addEffect(filter);
}

// Convert a spectrum value into a y pixel position
int spectrum_y(float bandval)
{
  float val;
  if (bandval > 0) {
    val = dB_scale*(20*((float)Math.log10(bandval)) + gain);
  } else {
    val = -200;  // avoid log(0)
  }
  int y = spectrum_height - Math.round(val);
  if (y > spectrum_height) { y = spectrum_height; }
  return y;
}

void draw()
{
  // clear window
  background(0);
  
  // perform a forward FFT on the samples in input buffer
  fft.forward(sound.mix);
  
  // highlight the BPF range
  noStroke();
  fill(128,0,0);
  int lowerbin = fft.freqToIndex(centerFreq - bandwidth/2);
  int upperbin = fft.freqToIndex(centerFreq + bandwidth/2);
  rect(legend_width+lowerbin, 0, max(1, upperbin-lowerbin), spectrum_height);
  
  // now draw current spectrum in brighter blue
  stroke(64,192,255);
  noFill();
  int y_prev = spectrum_y(fft.getBand(0));
  for(int i = 1; i < spectrum_width; i++)  {
    // draw the line for frequency band i using dB scale
    int y = spectrum_y(fft.getBand(i));
    line(legend_width+i-1, y_prev, legend_width+i, y);
    y_prev = y;
  }
  
  // add legend
  // frequency axis
  fill(255);
  stroke(255);
  int y = spectrum_height;
  line(legend_width,y,legend_width+spectrum_width,y); // horizontal line
  // x,y address of text is immediately to the left of the middle of the letters 
  textAlign(CENTER,TOP);
  for (float freq = 0.0; freq < sound.sampleRate()/2; freq += 2000.0) {
    int x = legend_width+fft.freqToIndex(freq); // which bin holds this frequency
    line(x,y,x,y+4); // tick mark
    text(Math.round(freq/1000) +"kHz", x, y+5); // add text label
  }
  
  // level axis
  int x = legend_width;
  line(x,0,x,spectrum_height); // vertictal line
  textAlign(RIGHT,CENTER);
  for (float level = -100.0; level < 100.0; level += 20.0) {
    y = spectrum_height - (int)(dB_scale * (level+gain));
    line(x,y,x-3,y);
    text((int)level+" dB",x-5,y);
  }

}

void keyReleased()
{
  // +/- used to adjust gain on the fly
  if (key == '+' || key == '=') {
    gain = gain + 5.0;
  } else if (key == '-' || key == '_') {
    gain = gain - 5.0;
  }
  // space bar to play/pause
  if (key == ' ') {
    if (paused == true) {
      sound.play();
    } else {
      sound.pause();
    }
    paused = !paused;
  }
}
 
void stop()
{
  // always close Minim audio classes when you finish with them
  sound.close();
  minim.stop();
 
  super.stop();
}

void mousePressed()
{
  mouseDragged();
}

void mouseDragged()
{
  // map the mouse position to frequency and bandwidth
  float mx = map(mouseX, legend_width, legend_width+spectrum_width, 0, 1);
  float my = map(mouseY, 0, spectrum_height, 1, 0);
  centerFreq = mx * sound.sampleRate() * spectrum_width/buffer_size;
  float Q = (float)Math.pow(100.0, my); // Q varies from 1 to 100 logarithmically
  bandwidth = centerFreq / Q;
  filter.setCoeffs(centerFreq, bandwidth, sound.sampleRate()); 
}




class Filter implements AudioEffect
{
  float [] stateL;
  float [] stateR;
  float [] ai;
  float [] bi;
  
  Filter(float [] as, float [] bs) 
  {
    ai = as;
    bi = bs;
    stateL = new float[max(ai.length, bi.length)];
    stateR = new float[max(ai.length, bi.length)];
  }
  
  Filter(float freq, float bw, float sampleRate)
  {  // initialize as 2p2z BPF
    ai = new float[3];
    bi = new float[3];
    stateL = new float[3];
    stateR = new float[3];
    setCoeffs(freq, bw, sampleRate);   
  }   
  
  void setCoeffs(float freq, float bw, float sampleRate)
  {  // initialize as 2p2z BPF
    // from http://www.ee.columbia.edu/~dpwe/e4810/lectures/L06-filters.pdf slide 14
    println("setCoeffs: freq="+freq+" bw="+bw+" sr="+sampleRate);
    float cosB = (float)Math.cos(bw/sampleRate * 2.0 * Math.PI);
    float alpha = 0.5*((2.0/cosB) - (float)Math.sqrt(4.0/cosB/cosB - 4));
    float r = (float)Math.sqrt(alpha);
    float beta = (float)Math.cos(freq/sampleRate * 2.0 * Math.PI);
    float theta = (float)Math.acos(beta * (1.0 + alpha) / (2.0*r) );
    float G = (1.0 - alpha)/2.0;
    // set coefficients
    bi[0] = G; bi[1] = 0; bi[2] = G;
    ai[0] = 0; ai[1] = beta * (1.0 + alpha); ai[2] = -alpha;
  }
  
  // process one channel
  void process_chan(float[] signal, float[] state)
  {
    for (int i = 0; i < signal.length; ++i) {
      // run the filter one step
      // DF2 filter - slide 30 of http://www.ee.columbia.edu/~dpwe/e4810/lectures/L07-filtermisc.pdf
      // move the state down
      System.arraycopy(state, 0, state, 1, state.length - 1);
      // calculate new input value
      float x = signal[i];
      for(int j = 1; j < ai.length; ++j) {  // skip first state for feedback
        x += ai[j] * state[j];
      }
      state[0] = x;
      // calculate output
      float y = 0;
      for(int j = 0; j < bi.length; ++j) {
        y += bi[j] * state[j];
      }
      // store the output in-place
      signal[i] = y;
    }
  }

  void process(float[] signal)
  {
    process_chan(signal, stateL);
  }
  
  void process(float[] sigLeft, float[] sigRight)
  {
    process_chan(sigLeft, stateL);
    process_chan(sigRight, stateR);
  }
}