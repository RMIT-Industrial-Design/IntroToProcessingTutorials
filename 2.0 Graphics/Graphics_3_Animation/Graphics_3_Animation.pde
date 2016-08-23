/*------------------------------------------------- 
 Animation ::
 
 * Using global variables to make simple animations
 * Adding conditionals
 * Introducing app properties:
 * ofSetWindowTitle(), ofSetWindowShape()
 * smooth(), ofSetCircleResolution()
 * width, height
 */

int circleX = 0;
int circleY = 0;

int rectX = 0;
int rectY = 0;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  frame.setTitle("My Awesome Animation!!");
  
  smooth();
  
}

// It's good practice to seperate variable maniuplation 
// and drawing 'logic' from the draw() method. 
// Get into the habbit of creating an update() method in which you 
// perform calculations each frame and then call it at the beginning 
// of each draw() loop. 
//-------------------------------------------------
void update() {
  circleX += 2;
  circleY += 1;

  // Uncomment this part to make the circle come back!
  if (circleX > width) {
    circleX = 0;
  }
  if (circleY > height) {
    circleY = 0;
  }

  //Uncomment this part to make the rect follow the mouse
  if (rectX < mouseX) {
    rectX += 2;
  } else if (rectX > mouseX) {
    rectX -= 2;
  }

  if (rectY < mouseY) {
    rectY += 2;
  } else if (rectY > mouseY) {
    rectY -= 2;
  }
}

//-------------------------------------------------
void draw() {
  update();

  background(95,122,155);
  
  //-------------animation trails :)
  //fill(255,5);
  //rect(0,0,width,height);
  
  fill(255, 0, 153);
  ellipse(circleX, circleY, 100, 100);

  fill(0, 99, 255);
  rect(rectX, rectY, 50, 50);
}