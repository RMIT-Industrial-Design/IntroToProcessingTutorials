/*------------------------------------------------- 
 Atan ::
 */

Arrow myArrow;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(20);

  myArrow = new Arrow();
}

//-------------------------------------------------
void update() {
  myArrow.update(mouseX, mouseY);
}

//-------------------------------------------------
void draw() {
  update();

  stroke(255);
  strokeWeight(2);
  myArrow.draw();
}