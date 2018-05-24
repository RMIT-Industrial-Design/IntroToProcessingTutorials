
class Ball {
  PVector baseSpeed;
  PVector speed = new PVector(0,0);
  PVector pos;
  color c = color(20,255,255);
  float radius = 20;
 
  Ball(PVector p) {
    pos = p; 
    baseSpeed = new PVector(random(2.5f,3.5f),random(2.5f,3.5f));    
    speed.set(baseSpeed);
    println("speed = "+ speed.x + " " + speed.y + " Base speed = " + baseSpeed.x + " " + baseSpeed.y);
  }
  
  void updateBall()
  {
    if((pos.x > width-radius) || (pos.x < 0+radius)) {
      speed.x = speed.x * -1; 
      c = color(random(0,256),random(0,256),random(0,256));
    }

    if((pos.y > height-radius) || (pos.y < 0+radius)) {
      speed.y = speed.y * -1;
      c = color(random(0,256),random(0,256),random(0,256));
    }
    pos = pos.add(speed);
  }
  
  void drawBall()
  {
    fill(c);
    ellipse(pos.x,pos.y,radius*2,radius*2);
  }
  
  void setColour(int col) 
  {
    c = color(col,255,255);
  }
  
  void setSpeed(PVector s)
  {
    println("s speed = "+ s.x + " " + s.y + " Base speed = " + baseSpeed.x + " " + baseSpeed.y);
    speed.x = baseSpeed.x * s.x;
    speed.y = baseSpeed.y * s.y;
        println("s speed = "+ speed.x + " " + speed.y + " Base speed = " + baseSpeed.x + " " + baseSpeed.y);
  }
  
  
  
  
}
