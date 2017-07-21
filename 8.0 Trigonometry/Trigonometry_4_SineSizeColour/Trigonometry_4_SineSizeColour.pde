/*------------------------------------------------- 
 Sine Size Colour ::
 Try and map the value of the sin wave to different colour channels.
 */

float alpha;
float size;

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void update() {

  float sinOfTime = sin(frameCount*0.05);
  size = map(sinOfTime, -1, 1, 10, 500);
  alpha = map(sinOfTime, -1, 1, 0, 255);
}

//-------------------------------------------------
void draw() {
  update();
  background(20);

  fill(255, alpha);
  ellipse(width/2, height/2, size, size);
}