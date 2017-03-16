import ddf.minim.*;
 
Minim minim;
AudioInput input;
 
float yStart = 384;
float yScale = 400;
 
//-------------------------------------- 
void setup() {
  size(1024, 768);
  smooth();
  noStroke();
  colorMode(HSB);
   
  minim = new Minim(this);
  input = minim.getLineIn (Minim.STEREO, 96);
}

//--------------------------------------
void draw() {
  background(0);
   
  // Reading and storing of the spectrum
  float[] buffer = input.mix.toArray();
  // Calculate width of the rectangles
  float step = ceil((float) width / buffer.length);
   
  for (int i = 1; i < buffer.length; i++) {
     
    // Positions for determining all 4 points
    float x1 = (i-1) * step;
    float x2 = i * step;
    float y1 = yStart + buffer[i-1] * yScale;
    float y2 = yStart + buffer[i] * yScale;
     
    // define fill color
    float h = (buffer[i-1] + buffer[i]) / 2;
    fill(h * 255, 255, 255);
     
    // draw rectangle
    beginShape(QUADS);
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x2, height);
    vertex(x1, height);
    endShape();
  }
}