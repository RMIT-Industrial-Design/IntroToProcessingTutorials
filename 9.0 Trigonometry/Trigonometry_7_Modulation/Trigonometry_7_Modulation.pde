/*------------------------------------------------- 
 Modulation ::
 */

PVector sinPos, prevSinPos;
PVector fmPos, prevFmPos;
PVector amPos, prevAmPos;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(20);

  sinPos = new PVector(0,200);
  fmPos = new PVector(0,400);
  amPos = new PVector(0,600);

}

//-------------------------------------------------
void update() {
  prevSinPos = sinPos;
  prevAmPos = amPos;
  prevFmPos = fmPos;

  float time = (frameCount*6.)*0.001;

  float sinOfTime = sin(time);
  float fmSinOfTime = sin(sin(time)*50);
  float amSinOfTime = sin(time) * sin(time*20);

  sinPos.y = 200 + (sinOfTime * 80);
  fmPos.y = 400 + (fmSinOfTime * 80);
  amPos.y = 600 + (amSinOfTime * 80);

  sinPos.x++;
  fmPos.x++;
  amPos.x++;
}

//-------------------------------------------------
void draw() {
  update();

  stroke(255);
  strokeWeight(2);
  line(prevSinPos.x, prevSinPos.y, sinPos.x, sinPos.y);
  line(prevFmPos.x, prevFmPos.y, fmPos.x, fmPos.y);
  line(prevAmPos.x, prevAmPos.y, amPos.x, amPos.y);
}