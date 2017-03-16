// Example by Matt Leaf 2014

int maxColor = 700;
int minColor = 200;// set this value for the start of the spectrum
int field = 100; // set this number for the size of the colorfield
int range = maxColor - field; //
float index = 1;

float c = minColor;
float move = 0;

//---------------------------------------------
void setup() {
  size(800, 600);
  colorMode(HSB, maxColor, 1, 1);
}

//---------------------------------------------
void update(){
  move++;
  if (move >= width) {
    move = 0;
  }

  // cycle through hues
  c = c + index;

  if (c >= range || c <= minColor) {
    index = -index;
  }
  
}

//---------------------------------------------
void draw() {
  update();
  
  // draw line
  stroke(c, 1, 1);
  line(move, 0, move, height);
}