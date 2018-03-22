/*
 * Playback_BPF
 * 
 * Plays a soundfile, sound.mp3.
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
AudioPlayer sound;

BandPass bpf;
FFT fft;
float centerFreq;
float bandwidth;

float gain = 60; // in dB

int spectrumScale = 2; // pixels per FFT bin

void setup()
{
  size(512, 200);
  textFont(createFont("SanSerif", 12));
  
  minim = new Minim(this);
  minim.debugOn();
  
  sound = minim.loadFile("sound.wav");
  // make it repeat
  sound.loop();

  // add in the bpf to the input
  centerFreq = 440;
  bandwidth = 20;
  bpf = new BandPass(centerFreq, bandwidth, sound.sampleRate());
  sound.addEffect(bpf);

  // create an FFT object that has a time-domain buffer 
  // the same size as line-in's sample buffer
  fft = new FFT(sound.bufferSize(), sound.sampleRate());
  // Tapered window important for log-domain display
  fft.window(FFT.HAMMING);

}

void mouseMoved()
{
  // map the mouse position to the range [100, 10000], an arbitrary range of passBand frequencies
  centerFreq = map(mouseX, 0, width, 0, sound.sampleRate()/(2*spectrumScale));
  bpf.setFreq(centerFreq);
  float bpfQ = 100 - map(mouseY, 0, height, 0, 98);  // lowest Q is 100-98 = 2;
  bandwidth = centerFreq/bpfQ;
  bpf.setBandWidth(bandwidth);
}


void draw()
{
  background(0);
  fft.forward(sound.mix);
  fill(64,192,255);
  noStroke();
  for(int i = 0; i < fft.specSize(); i++)
  {
    // draw the line for frequency band i using dB scale
    float val = 2*(20*((float)Math.log10(fft.getBand(i))) + gain);
    rect(i*spectrumScale, height, spectrumScale, -Math.round(val));
  }
  // add band showing BPF
  fill(255, 0, 0, 80);
  rect(mouseX - bpf.getBandWidth()/20, 0, bpf.getBandWidth()/10, height);
  // report center frequency
  fill(255);
  text("Center frequency="+Math.round(centerFreq)+" Hz bw="+Math.round(bandwidth), 5, 20);
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
  sound.close();

  minim.stop();

  super.stop();
}