/**
  * SinePiano
  * 
  * Dan Ellis, dpwe@ee.columbia.edu, 2010-01-22
  *
  * This sketch lets you play notes or chords using the computer keyboard as a piano keyboard.
  * The 'Z' key is C4, and running up the bottom row to '/' plays a little over an octave, 
  * with the black notes coming from the row above.
  *
  * The actual sounds are generated by instances of SineWave, created in response to each 
  * keypress.  The amplitude decays with each successive buffer, giving a nice exponential 
  * decay sound.
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
  MyNote newNote;

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
      newNote = new MyNote(pitch, 0.2);
   }
}

void stop()
{
  out.close();
  minim.stop();
 
  super.stop();
}

class MyNote implements AudioSignal
{
     private float freq;
     private float level;
     private float alph;
     private SineWave sine;
     
     MyNote(float pitch, float amplitude)
     {
         freq = pitch;
         level = amplitude;
         sine = new SineWave(freq, level, out.sampleRate());
         alph = 0.9;  // Decay constant for the envelope
         out.addSignal(this);
     }

     void updateLevel()
     {
         // Called once per buffer to decay the amplitude away
         level = level * alph;
         sine.setAmp(level);
         
         // This also handles stopping this oscillator when its level is very low.
         if (level < 0.01) {
             out.removeSignal(this);
         }
         // this will lead to destruction of the object, since the only active 
         // reference to it is from the LineOut
     }
     
     void generate(float [] samp)
     {
         // generate the next buffer's worth of sinusoid
         sine.generate(samp);
         // decay the amplitude a little bit more
         updateLevel();
     }
     
    // AudioSignal requires both mono and stereo generate functions
    void generate(float [] sampL, float [] sampR)
    {
        sine.generate(sampL, sampR);
        updateLevel();
    }

}