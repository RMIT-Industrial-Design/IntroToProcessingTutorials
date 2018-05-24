import controlP5.*;

ControlP5 gui;

float size;
float diameter = 10.0f;

void setup()
{
  size(800,800);
  gui = new ControlP5(this);
  gui.addSlider("size")
     .setPosition(20,20)
     .setRange(1.0f,100.0f)
     .setValue(1.0f);  
}

void draw()
{
  background(200);
  fill(0);
  ellipse(width/2,height/2,diameter*size,diameter*size);
}
