/*------------------------------------------------- 
 Noise ::
 */

ofPixels noisePixels;
PImage noiseImg;
float mult;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  mult = 0.01;
  noisePixels.allocate(ofGetWidth(), ofGetHeight(), OF_IMAGE_COLOR);
}

//-------------------------------------------------
void update() {
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      color c = color(noise(x*mult, y*mult));
      //      ofFloatColor color = ofFloatColor(ofNoise(x*mult, y*mult));
      noisePixels.setColor(x, y, c);
    }
  }

  noiseImg.setFromPixels(noisePixels.getPixels(), noisePixels.getWidth(), noisePixels.getHeight(), OF_IMAGE_COLOR);
}

//-------------------------------------------------
void draw() {
  update();

  fill(255);
  image(noiseImg,0,0);

  String debug = "Press up/down arrows to change noise multiplier \n"
    + " Multiplier: " + str(mult); 
  fill(255, 0, 0);
  text(debug, 30, 30);
}

//-------------------------------------------------
void keyPressed() {
  switch (key) {
  case UP:
    mult *= 2;
    break;

  case DOWN:
    mult *= 0.5;
    break;

  default:
    break;
  }
}