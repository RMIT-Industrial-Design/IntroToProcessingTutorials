/**
  * KSPiano
  * 
  * Dan Ellis, dpwe@ee.columbia.edu, 2010-01-22
  *
  * This sketch lets you play notes or chords using the computer keyboard as a piano keyboard.
  * The 'Z' key is C4, and running up the bottom row to '/' plays a little over an octave, 
  * with the black notes coming from the row above.
  *
  * The actual sounds are generated with the Karplus-Strong plucked string algorithm.  
  * On creating a note, a buffer the length of one cycle is filled with random noise. 
  * Each time one point is read from the buffer and passed as a sample value to the 
  * output, that point is replaced by a smoothed version based on K local points.
  * This leads to a gradual dying-away of the sound.  
  *
  * In this version, notes are forcibly terminated after sounding for 10 seconds.
  * 
  */
 
import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;
 
Minim minim;
AudioOutput out;

void setup()
{
  size(512, 200, P3D);
 
  minim = new Minim(this);
  // get a line out from Minim, default bufferSize is 1024, default sample rate is 44100, bit depth is 16
  out = minim.getLineOut(Minim.STEREO);
}
 
void draw()
{
  background(0);
  stroke(255);
  // draw the output waveforms, so there's something to look at
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    line(x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
    line(x1, 150 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
  }
}
 
void keyPressed()
{
  SineWave mySine;
  KSNote newNote;

  // Map the key to a pitch (in Hz), and instantiate the Note object  
  float pitch = 0;
  switch(key) {
    case 'z': pitch = 262; break;
    case 's': pitch = 277; break;
    case 'x': pitch = 294; break;
    case 'd': pitch = 311; break;
    case 'c': pitch = 330; break;
    case 'v': pitch = 349; break;
    case 'g': pitch = 370; break;
    case 'b': pitch = 392; break;
    case 'h': pitch = 415; break;
    case 'n': pitch = 440; break;
    case 'j': pitch = 466; break;
    case 'm': pitch = 494; break;
    case ',': pitch = 523; break;
    case 'l': pitch = 554; break;
    case '.': pitch = 587; break;
    case ';': pitch = 622; break;
    case '/': pitch = 659; break;
  }
  
   if (pitch > 0) {
      newNote = new KSNote(pitch, 0.2);
   }
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

class KSNote implements AudioSignal
{
     private float freq;
     private float level;
     private float alph;
     private float[] buffer;
     private int length;
     private int pointer;
     private float elapsed;
     private int average_halfwin = 2;  // half the window over which moving average is taken
     private float max_duration = 5.0;  // notes are cutoff after this many seconds
     
     KSNote(float pitch, float amplitude)
     {
         freq = pitch;
         level = amplitude;

         // Create a new buffer of exactly one pitch period in length
         length = Math.round(out.sampleRate()/pitch);
         // .. and fill it with random noise
         buffer = new float[length];
         float sum = 0;
         for (int i=0; i<length; ++i) {
           buffer[i] = level*((float)Math.random()-0.5);
           sum += buffer[i];
         }
         // Remove DC to avoid click when note terminates
         sum = sum/length;
         for (int i=0; i<length; ++i) {
           buffer[i] -= sum;
         }

         // initialize where next sample comes from
         pointer = 0;

         // Start the elapsed duration clock
         elapsed = 0;

         out.addSignal(this);
     }
     
     void generate(float [] samp)
     {
         // Run the Karplus-Strong plucked string algorithm
         for (int i = 0; i < samp.length; ++i) {
           float newval = 0;
           samp[i] = buffer[pointer];
           // Run the smoothing filter to replace the point we just read out
           for (int j = -average_halfwin; j <= average_halfwin; ++j) {
             newval = newval + buffer[(pointer+j+length) % length];  // make sure it wraps at the ends
           }
           newval = newval/(2*average_halfwin+1);  // K-point moving average
           buffer[pointer] = newval;
           // advance the pointer
           pointer = (pointer + 1)%length;
         }
         // check for end of note
         elapsed += samp.length/out.sampleRate();
         if (elapsed > max_duration) {  // hard time limit
            out.removeSignal(this);
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