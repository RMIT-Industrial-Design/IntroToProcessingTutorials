/*------------------------------------------------- 
 Simple Harmonic Motion ::
 */

float alpha;
float size;

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//-------------------------------------------------
void update() {
}

//-------------------------------------------------
void draw() {
  update();
  background(20);

  for (float i = 1; i < 32; i++) {

    float sinOfTime = sin((frameCount*0.002)*i);
    float offset = sinOfTime * 150;
    float x = i*30;
    float y = height/2 + offset;
    ellipse(x, y, 10, 10);
  }
}