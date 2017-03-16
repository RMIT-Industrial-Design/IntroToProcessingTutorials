/*------------------------------------------------- 
 Translate and Rotate ::
 */

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void update() {
}

//-------------------------------------------------
void draw() {
  background(255);
  fill(0);

  pushMatrix();
    translate(width*0.5, height*0.5);
    rotate(60);
    rect(0, 0, 50, 50);
  popMatrix();

  rect(50, 50, 50, 50);
}