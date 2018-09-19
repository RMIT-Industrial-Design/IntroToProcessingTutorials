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
     .setRange(1.0,100.0)
     .setWidth(300)
     .setHeight(50)
     .setColorActive(color(255,0,255))
     .setColorForeground(color(255,0,0))
     .setColorBackground(color(0,255,0))
     .setValue(50.0);  
}

void draw()
{
  background(200);
  fill(0);
  ellipse(width/2,height/2,diameter*size,diameter*size);
}
