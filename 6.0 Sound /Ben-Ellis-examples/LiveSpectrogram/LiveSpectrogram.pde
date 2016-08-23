/**
 * LiveSpectrogram
 * Takes successive FFTs and renders them onto the screen as grayscale, scrolling left.
 *
 * Dan Ellis dpwe@ee.columbia.edu 2010-01-15
 */
 
import ddf.minim.analysis.*;
import ddf.minim.*;
 
Minim minim;
AudioInput in;
FFT fft;

// Configuration: spectrogram size (pixels)
int colmax = 500;
int rowmax = 250;
// Sample rate 
float sampleRate = 22050;
// buffer size (= FFT size, must be power of 2)
int bufferSize = 1024;

// Variables
int[][] sgram = new int[rowmax][colmax];
int col;
int leftedge;

void setup()
{
  size(580, 250, P3D);
  textMode(SCREEN);
  textFont(createFont("SanSerif", 12));
 
  minim = new Minim(this);
  
  // setup audio input
  in = minim.getLineIn(Minim.MONO, bufferSize, sampleRate);
 
  fft = new FFT(in.bufferSize(), in.sampleRate());
  // use a tapered window (to avoid "splatter")
  fft.window(FFT.HAMMING);
}
 
void draw()
{
  background(0);
  stroke(255);
  // perform a forward FFT on the samples in the input buffer  
  fft.forward(in.mix);

  for(int i = 0; i < rowmax /* fft.specSize() */; i++)
  {
    // fill in the new column of spectral values
    sgram[i][col] = (int)Math.round(Math.max(0,2*20*Math.log10(1000*fft.getBand(i))));
  }
  // next time will be the next column
  col = col + 1; 
  // wrap back to the first column when we get to the end
  if (col == colmax) { col = 0; }
  
  // Draw points.  
  // leftedge is the column in the ring-filled array that is drawn at the extreme left
  // start from there, and draw to the end of the array
  for (int i = 0; i < colmax-leftedge; i++) {
    for (int j = 0; j < rowmax; j++) {
      stroke(sgram[j][i+leftedge]);
      point(i,height-j);
    }
  }
  // Draw the rest of the image as the beginning of the array (up to leftedge)
  for (int i = 0; i < leftedge; i++) {
    for (int j = 0; j < rowmax; j++) {
      stroke(sgram[j][i]);
      point(i+colmax-leftedge,height-j);
    }
  }
  // Next time around, we move the left edge over by one, to have the whole thing
  // scroll left
  leftedge = leftedge + 1; 
  // Make sure it wraps around
  if (leftedge == colmax) { leftedge = 0; }
  
  // Add frequency axis
  int x = colmax + 2; // to right of spectrogram display
  stroke(255);
  line(x,0,x,height); // vertical line
  // x,y address of text is immediately to the left of the middle of the letters 
  textAlign(LEFT,CENTER);
  for (float freq = 0.0; freq < in.sampleRate()/2; freq += 500.0) {
    int y = height - fft.freqToIndex(freq); // which bin holds this frequency
    line(x,y,x+3,y); // tick mark
    text(Math.round(freq)+" Hz", x+5, y); // add text label
  }
}
 
 
void stop()
{
  // always close Minim audio classes when you finish with them
  in.close();
  minim.stop();
 
  super.stop();
}