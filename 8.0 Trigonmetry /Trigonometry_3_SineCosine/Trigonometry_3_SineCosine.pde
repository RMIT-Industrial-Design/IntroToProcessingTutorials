/*------------------------------------------------- 
 Radians & Degress ::
 */

float angle;
float degrees = 0;
float radius = 100;
float sinX, cosY;
PVector center;
PVector rotCircle;
PVector sinCircle;
PVector cosCircle;

PShape sinPath;
PShape cosPath;

//-------------------------------------------------
void setup() {
  size(1024, 768, P2D);

  center = new PVector(width/2, height/2);
  rotCircle = new PVector();
  sinCircle = new PVector();
  cosCircle = new PVector();

  sinX =0;// center.x + 150;
  cosY = 0;

  sinPath = createShape();
  sinPath.beginShape(QUAD_STRIP);
  sinPath.strokeWeight(3);
  sinPath.stroke(255, 0, 0);

  cosPath = createShape();
  cosPath.beginShape(QUAD_STRIP);
  cosPath.strokeWeight(3);
  cosPath.stroke(255, 0, 255);
}

//-------------------------------------------------
void update() {
  angle += 0.05;

  if (sinX == 0) {
    sinPath.beginShape(POINTS);
    sinX += 1;
  } else if (sinX > 359) {
    sinX = 0;
    sinPath.endShape(CLOSE);
  } else {
    sinPath.vertex(sinCircle.x, sinCircle.y);
    sinX += 1;
  }

  if (cosY == 0) {
    cosPath.beginShape(POINTS);
    cosY += 1;
  } else if (cosY > 359) {
    cosY = 0;
    cosPath.endShape(CLOSE);
  } else {
    cosPath.vertex(cosCircle.x, cosCircle.y);
    cosY += 1.5;
  }


  float x = cos(angle)*radius;
  float y = sin(angle)*radius;

  rotCircle.set(center.x + x, center.y + y);
  sinCircle.set(sinX, rotCircle.y);
  cosCircle.set(rotCircle.x, cosY);
}

//-------------------------------------------------
void draw() {
  update();
  background(220);

  fill(255);

  //rotating circle
  ellipse(rotCircle.x, rotCircle.y, 10, 10);

  //sine wave to Y
  ellipse(sinCircle.x, sinCircle.y, 10, 10);
  shape(sinPath);

  //cos wave to X
  ellipse(cosCircle.x, cosCircle.y, 10, 10);
  shape(cosPath);

  fill(255, 0, 0);
  ellipse(center.x, center.y, 5, 5);

  line(rotCircle.x, rotCircle.y, sinCircle.x, sinCircle.y);
  line(rotCircle.x, rotCircle.y, cosCircle.x, cosCircle.y);
}