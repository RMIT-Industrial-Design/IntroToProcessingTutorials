import ddf.minim.*;
 
float x;
float y;
Minim minim;
AudioInput input;
 
//----------------------------------
void setup() {
  size(1024, 768);
  smooth();
  stroke(255, 25);
  noFill();
   
  // Setting the start location
  x = 0;
  y = 20;
   
  minim = new Minim(this);
  input = minim.getLineIn(Minim.STEREO, 512);
  background(0);
}

//----------------------------------
void draw() {
  float dim = input.mix.level () * width;
  x += input.mix.level() * 20;
  ellipse(x, y, dim, dim);
   
  if (x > width) {
    x = 0;
    y += 20;
  }
}