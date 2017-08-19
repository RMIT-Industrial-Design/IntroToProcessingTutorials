Particle p;

void setup()
{
  background(0);
  size(800,800);
  
  p = new Particle();
  p.setPosition(width/2,height/2);
  p.size = random(10,40);
  p.setSpeed(random(-1.0f,1.0f),random(-1.0f,1.0f));
  p.setColour(color(255,0,255));  
}

void draw()
{
  background(0);

  p.drawParticle();
  p.update();


}