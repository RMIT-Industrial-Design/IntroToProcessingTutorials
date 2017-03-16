/*------------------------------------------------- 
 Trigonometry ::
 */

float x;
float px, py;
float px2, py2;
float angle, angle2;
float radius = 50;
float frequency, frequency2 = 2;

//-------------------------------------------------
void setup() {
  size(600, 200);
}

//-------------------------------------------------
void update() {
}

//-------------------------------------------------
void draw() {
  update();

  background(230);

  rectMode(CENTER);

  fill(255);
  ellipse(width/8, 75, radius, radius);

  // rotates rectangle around circle
  px = width/8 + cos(radians(angle))*(radius);
  py = 75 + sin(radians(angle))*(radius);

  fill(0);

  //draw rectangle
  rect(px, py, 5, 5);
  fill(100);
  line(width/8, 75, px, py);
  fill(200);

  // keep reinitializing to 0, to avoid
  // flashing during redrawing
  angle2 = 0;

  // draw static curve - y = sin(x)
  for (int i = 0; i< width; i++) {
    px2 = width/8 + cos(radians(angle2))*(radius);
    py2 = 75 + sin(radians(angle2))*(radius);
    rect(width/8+radius+i, py2, 1, 1);
    angle2 -= frequency2;
  }

  // send small ellipse along sine curve
  // to illustrate relationship of circle to wave
  ellipse((width/8)+radius+x, py, 4, 4);
  angle -= frequency;
  x+=1;

  // when little ellipse reaches end of window
  // reinitialize some variables
  if (x >= width-60) {
    x = 0;
    angle = 0;
  }

  // draw dynamic line connecting circular
  // path with wave
  fill(50);
  line(px, py, width/8+radius+x, py);

  // output some calculations
  text("y = sin x", 35, 185);
  text("px = " + str(px), 115, 185);
  text("py = " + str(py), 225, 185);
}