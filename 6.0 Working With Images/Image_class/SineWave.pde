import processing.sound.*;

class SineWave{
  SinOsc sine;
 float amp;
 float freq;
 
 // Constructor 
 SineWave(PApplet papp, float _freq){
   freq = _freq;
   amp = 0.0;
   
   // Create a new sine oscillator.
   sine = new SinOsc(papp);
   sine.amp(amp);
   sine.freq(freq);
   sine.play();
 }
 
 void exit(){
  sine.stop(); 
 }
 void setAmp(float _amp){
  amp = _amp; 
  sine.amp(amp);
 }
  
}