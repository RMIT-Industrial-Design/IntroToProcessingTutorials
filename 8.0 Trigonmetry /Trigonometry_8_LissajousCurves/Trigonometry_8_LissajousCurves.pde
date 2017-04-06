/*------------------------------------------------- 
 LissajousCurves ::
 */

float angle;
PVector pos, prevPos;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(20);

  pos = new PVector();
  prevPos = new PVector();
}

//-------------------------------------------------
void update() {
  angle = frameCount*0.004;

  PVector center = new PVector(width/2, height/2);

  float lissajousSin = sin(angle * 10.0);
  float lissajousCos = cos(angle * 9.5);

  prevPos = pos;

  pos.x = center.x + lissajousCos * 200;
  pos.y = center.y + lissajousSin * 200;
}

//-------------------------------------------------
void draw() {
  update();

  stroke(255);
  strokeWeight(2);
  line(prevPos.x, prevPos.y, pos.x, pos.y);
}