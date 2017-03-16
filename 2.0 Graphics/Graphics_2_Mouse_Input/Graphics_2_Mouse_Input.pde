/*------------------------------------------------- 
 Drawing with Mouse Input ::
 
 * Different ways of using mouse coordinates
 1. mouseX and mouseY variables
 2. passing coords from mouse event to global variables
 a) mouseDragged
 b) mousePressed
 */

int rectWidth = 0;
int rectHeight = 0;

int red = 230;
int blue = 180;

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void draw() {

  // 1. mouseX and mouseY variables
  fill(0, 230, 180, 50);
  ellipse(mouseX, mouseY, 80, 80);

  // 2. passing coords from mouse event to global variables
  fill(red, 0, blue, 100);
  rect(0, 0, rectWidth, rectHeight);
}

//-------------------------------------------------
void mouseDragged(){
  rectWidth = mouseX;
  rectHeight = mouseY;
}

//-------------------------------------------------
void mousePressed(){
  red = mouseX;
  blue = mouseY;
}