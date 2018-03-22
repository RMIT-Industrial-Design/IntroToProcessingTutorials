/*
 * AudioSocket_BPF
 * 
 * Echos live input to output, using AudioSocket.
 * Applies a BPF, which is controlled interactively by the mouse 
 * (left-right is frequency, up-down is Q/bandwidth).
 * Plots the instantaneous spectrum, showing the effect of the filter.
 *
 * 2010-01-22 Dan Ellis dpwe@ee.columbia.edu
 */

import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
AudioOutput out;
AudioSocket socket;

BandPass bpf;
FFT fft;

float gain = 80; // in dB

int spectrumScale = 4; // pixels per FFT bin

void setup()
{
  size(512, 200);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  int buffer_size = 1024;
  in = minim.getLineIn(Minim.STEREO, buffer_size);
  out = minim.getLineOut(Minim.STEREO, buffer_size);

  // Create the socket to connect input to output
  socket = new AudioSocket(buffer_size);
  // Connect the socket as a "listener" for the line-in
  in.addListener(socket);
  // .. and then connect it as a "signal" for the line-out
  out.addSignal(socket);

  // add in the bpf to the input
  bpf = new BandPass(440, 20, in.sampleRate());
  in.addEffect(bpf);

  // create an FFT object that has a time-domain buffer 
  // the same size as line-in's sample buffer
  fft = new FFT(in.bufferSize(), in.sampleRate());
  // Tapered window important for log-domain display
  fft.window(FFT.HAMMING);

}

void mouseMoved()
{
  // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
  float passBand = map(mouseX, 0, width, 0, in.sampleRate()/(2*spectrumScale));
  bpf.setFreq(passBand);
  float bpfQ = 100 - map(mouseY, 0, height, 0, 98);  // lowest Q is 100-98 = 2;
  bpf.setBandWidth(passBand/bpfQ);
  // prints the new values of the coefficients in the console
  bpf.printCoeff();
}


void draw()
{
  background(0);
  fft.forward(in.mix);
  fill(64,192,255);
  noStroke();
  for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i using dB scale
    float val = 2*(20*((float)Math.log10(fft.getBand(i))) + gain);
    rect(i*spectrumScale, height, spectrumScale, -Math.round(val));
  }
}

void keyReleased()
{
  // +/- used to adjust gain on the fly
  if (key == '+' || key == '=') {
    gain = gain + 3.0;
  } else if (key == '-' || key == '_') {
    gain = gain - 3.0;
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  in.close();
  out.close();

  minim.stop();

  super.stop();
}

class AudioSocket implements AudioListener, AudioSignal
{

  private float[] left;
  private float[] right;
  private int buffer_max;
  private int inpos, outpos;
  private int count;
  
  // AudioSocket makes and AudioSignal out of an AudioListener.
  // That is, it will accept the samples supplied to it by other 
  // AudioSignals (like an AudioListener), but then it will 
  // pass these on to any listeners to which it is connected.
  // To deal with scheduling asynchronies, it maintains an 
  // internal FIFO buffer to temporarily stage samples it 
  // has been given until it has somewhere to send them.
  
  // Assumes that samples will always enter and exit in blocks 
  // of buffer_size, so we don't have to worry about splitting 
  // blocks across the ring-buffer boundary

  AudioSocket(int buffer_size)
  {
     int n_buffers = 4;
     buffer_max = n_buffers * buffer_size;
     left = new float[buffer_max];
     right = new float[buffer_max];
     inpos = 0;
     outpos = 0;
     count = 0;
  }

  // The AudioListener:samples method accepts new input samples
  synchronized void samples(float[] samp)
  {
    // handle mono by writing samples to both left and right
    samples(samp, samp);
  }

  synchronized void samples(float[] sampL, float[] sampR)
  {
    System.arraycopy(sampL, 0, left, inpos, sampL.length);
    System.arraycopy(sampR, 0, right, inpos, sampR.length);
    inpos += sampL.length;
    if (inpos == buffer_max) {
      inpos = 0;
    }
    count += sampL.length;
    // println("samples: count="+count);
  }

  // The AudioSignal:generate method supplies new output 
  // samples when requested
  void generate(float[] samp)
  {
     // println("generate: count="+count);
     if (count > 0) {
       System.arraycopy(left, outpos, samp, 0, samp.length);
       outpos += samp.length;
       if (outpos == buffer_max) {
         outpos = 0;
       }
       count -= samp.length;
     }
  }

  void generate(float[] sampL, float[] sampR)
  {
     // handle stereo by copying one channel, then passing the other channel 
     // to the mono handler which will update the pointers
     if (count > 0) {
       System.arraycopy(right, outpos, sampR, 0, sampR.length);
       generate(sampL);
     }
  }
}