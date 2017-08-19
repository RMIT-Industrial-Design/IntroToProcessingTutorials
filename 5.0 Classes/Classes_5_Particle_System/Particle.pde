
class Particle
{
  float x;
  float y;
  float speedx;
  float speedy;
  float gravity;
  float size;
  color c;
  
  void setPosition(int _x, int _y)
  {
    x = _x;
    y = _y;
  }
  
  void setSpeed(float _x, float _y)
  {
    speedx = _x;
    speedy = _y;
  }
  
  void setColour(color _c)
  {
    c = _c;  
  }
  
  void update()
  {
    x = x + speedx;
    y = y + speedy;
  }
  
  void drawParticle()
  {
    fill(c);
    ellipse(x,y,size,size);
  }
  
  
}