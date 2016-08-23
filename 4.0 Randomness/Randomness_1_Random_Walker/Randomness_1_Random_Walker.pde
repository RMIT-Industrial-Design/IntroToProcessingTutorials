/*------------------------------------------------- 
 Random Walker ::
 */

CustomCircle myCirc;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(180);

  myCirc = new CustomCircle();
  myCirc.setup();
}

//-------------------------------------------------
void update() {
  myCirc.update();
}

//-------------------------------------------------
void draw() {
  update();
  myCirc.draw();
}