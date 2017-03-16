/*------------------------------------------------- 
 Loops ::
 
 * Using loops and mouse coordinates to draw an interactive pattern
 a) Simple loop
 b) Nested loop
 
 * More color:
 * color
 * colorMode : RGB, HSB
 * creating Gradients 
 */

// Constants
static int Y_AXIS = 1;
static int X_AXIS = 2;

// Variables
int spacing = 20;
int rectSize = 10;

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void update() {
  // For more interactions, play with these two:
  // spacing = mouseY/10;
  // rectSize = mouseX/20;
}

//-------------------------------------------------
void draw() {
  update();

  // Gradient Background
  color color1, color2;
  colorMode(RGB, 255);
  color1 = color(0, 240, 120);
  color2 = color(0, 120, 240);
  setGradient(0, 0, width, height, color1, color2, Y_AXIS);

  colorMode(HSB);
  
  // 1. Simple loop
  for (int x = 0; x < mouseX; x += spacing) {
    color rectColor = color(x*255/width, 255, 255);
    fill(rectColor);
    rect(x, 0, rectSize, rectSize);
  }

  // 2. Nested loop! :O
  //for (int x = 0; x < mouseX; x += spacing) {
  //  for (int y = 0; y < mouseY; y += spacing) {
  //    color rectColor = color(x*255/width, y*255/height, 255);
  //    fill(rectColor);
  //    rect(x, y, rectSize, rectSize);
  //  }
  //}
}

//-------------------------------------------------
void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  } else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}