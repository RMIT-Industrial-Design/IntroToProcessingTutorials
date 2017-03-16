import ddf.minim.*;
import ddf.minim.analysis.*;
  
Minim minim;
AudioInput input;
FFT fft;
 
float maxSpec = 0;

//--------------------------------------- 
void setup() {
  size(320, 240);
  noStroke();
   
  // Create and setup Minim with mic input
  // Set '256' to determine the resolution of the spectrum
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 256);
  // FFT instance for spectrum analysis
  fft = new FFT (input.bufferSize(), input.sampleRate());
}

//---------------------------------------
void draw() {
  background(0);
   
  float g = 0;    // Fill Colour
  float h = 0;    // Height of rectangle and line
  float specStep; 
  float specScale = (float) width / (fft.specSize () - 1);
   
  // Create the ' frequency groups ' ( 16 section )
  // Possible steps : 2-4-8-16-32-64-128
  float[] group = getGroup(16);
   
  // Drawing the detailed frequency spectrum
  noStroke();
  for (int i = 0; i < fft.specSize(); i++) {
    g = map(fft.getBand(i), 0, maxSpec, 50, 255);
    h = map(fft.getBand(i), 0, maxSpec, 2, height);
    fill(0, g, 0);
    rect(i * specScale, height - h, specScale, h);
  }
   
  // Draw the groups ( lines )
  stroke(255, 255, 0, 200);
  specStep = width / group.length;
  for (int i = 0; i < group.length; i++) {
    h = height - map (group[i], 0, maxSpec, 0, height);
    line(i * specStep, h, (i+1) * specStep, h);
  }
}
 
/* 
 * Finction combines the present FFT spectrum
 * together and gives their mean back
 */
//---------------------------------------
float[] getGroup(int theGroupNum) {
  fft.forward(input.mix);
   
  // Empty array for creating groups
  float[] group  = new float[theGroupNum];
  int specLimit  = fft.specSize () - 1;
  // number of frequencies per group
  int groupSize = specLimit / theGroupNum;
   
  // Fill all groups with a starting value of 0
  for (int i = 0; i < group.length; i++) {
    group[i] = 0;
  }
   
  // For each FFT frequency band
  for (int i = 0; i < specLimit; i++) {
    // Maximum?
    if (fft.getBand(i) > maxSpec) {
      maxSpec = fft.getBand (i);
    }
    int index = (int) Math.floor (i / groupSize);
    group[index] += fft.getBand(i);
  }
   
  for (int i = 0; i < group.length; i++) {
    group[i] /= groupSize;
  }

  return group;
}