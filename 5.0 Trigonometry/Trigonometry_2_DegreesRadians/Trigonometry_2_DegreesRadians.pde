/*------------------------------------------------- 
 Radians & Degress ::
 */

float degrees = 0;
float radius = 300;
float sine, cosine;

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void update() {
  degrees += 0.5;

  if (degrees > 359) degrees = 0;

  sine = sin(radians(degrees));
  cosine = cos(radians(degrees));
}

//-------------------------------------------------
void draw() {
  update();
  background(220);

  PVector center = new PVector(width/2, height/2);
  float y = center.y + (sine * radius);
  float x = center.x + (cosine * radius);

  fill(255);
  ellipse(center.x, center.y, 5, 5);
  ellipse(x, y, 15, 15);

  String debug = "Degrees: " + str(degrees) 
    + " Pi Radians: " + str(radians(degrees)) 
    + " Sine: " + str(sine) 
    + " Cosine: " + str(cosine);

  fill(255, 0, 0);
  text(debug, x + 25, y);

  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  line(x, y, x, center.y);
  line(x, y, center.x, y);
  line(center.x, center.y, x, y);
}