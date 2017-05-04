/* 
 * Oscilloscope
 *
 * Take live input and plot the waveform.
 * Includes 'trigger' to try to line up left edge of waveform with 
 * large positive slope.
 * Keyboard control:
 *  '+', '-' - adjust gain (vertical scale)
 *  '<', '>' - adjust timebase (horizontal scale)
 * 
 * 2010-01-25 Dan Ellis dpwe@ee.columbia.edu
 */

import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioInput in;

float gain = 200;
int tbase = 1024;
float[] myBuffer;

void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO,2048);

  myBuffer = new float[in.bufferSize()];
}
 
void draw()
{
  background(0);
  stroke(255);
  // draw the output waveforms, so there's something to look at
  // first grab a stationary copy
  for (int i = 0; i < in.bufferSize(); ++i) {
    myBuffer[i] = in.left.get(i);
  }
  // find trigger point as largest +ve slope in first 1/4 of buffer
  int offset = 0;
  float maxdx = 0;
  for(int i = 0; i < myBuffer.length/4; ++i)
  {
      float dx = myBuffer[i+1] - myBuffer[i]; 
      if (dx > maxdx) {
        offset = i;
        maxdx = dx;
      }
  }
  // plot out that waveform
  int mylen = min(tbase, myBuffer.length-offset);
  for(int i = 0; i < mylen - 1; i++)
  {
    float x1 = map(i, 0, tbase, 0, width);
    float x2 = map(i+1, 0, tbase, 0, width);
    line(x1, 100 - myBuffer[i+offset]*gain, x2, 100 - myBuffer[i+1+offset]*gain);
  }
}

void keyPressed()
{
  switch(key) {
    case '+': gain = gain * 1.5; break;
    case '-': gain = gain / 1.5; break;
    case '<': tbase = tbase / 2; break;
    case '>': tbase = 2*tbase; break;
  }
}
 
void stop()
{
  // always close Minim audio classes when you finish with them
  in.close();
  minim.stop();
 
  super.stop();
}