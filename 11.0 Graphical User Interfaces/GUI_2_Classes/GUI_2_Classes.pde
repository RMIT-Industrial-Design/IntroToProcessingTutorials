import controlP5.*;

ControlP5 gui;

Ball b;

void setup() 
{
  frameRate(60);
  size(900,900,P2D);
  colorMode(HSB, 255);

  b = new Ball(new PVector(width/2,height/2));
  
  gui = new ControlP5(this);
    
  gui.addSlider("colourSlider")
     .setPosition(20,20)
     .setRange(0,255)
     .setValue(128);
     
  gui.addSlider("speedXSlider")
     .setPosition(20,50)
     .setRange(0,3.0f)
     .setValue(1.0f);
     
  gui.addSlider("speedYSlider")
     .setPosition(20,80)
     .setRange(0,3.0f)
     .setValue(1.0f);      
}

void draw() 
{
  background(128);
  b.updateBall();
  b.drawBall();
}

void colourSlider(int c) 
{
  b.setColour(c);
}

void speedXSlider(float s) 
{
  println("s = " + s);
  b.setSpeed(new PVector(s,b.speed.y));
}

void speedYSlider(float s) 
{
  b.setSpeed(new PVector(b.speed.y,s));
}
