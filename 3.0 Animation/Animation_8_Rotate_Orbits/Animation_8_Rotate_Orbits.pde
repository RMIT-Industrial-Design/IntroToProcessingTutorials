/*------------------------------------------------- 
 Translate and Rotate around Orbits ::
 */

int rotOne = 0;
int rotTwo = 0;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(255);
}

//-------------------------------------------------
void update() {
  // Try experimenting with different values to create new patterns
  rotOne += 1;
  rotTwo += 4;
}

//-------------------------------------------------
void draw() {
  update();
  
  fill(0);

  translate(width*0.5, height*0.5);
  ellipse(0, 0, 50, 50);

  rotate(rotOne);
  translate(230, 0);
  ellipse(0, 0, 20, 20);

  rotate(rotTwo);
  translate(100, 0);
  ellipse(0, 0, 10, 10);
}