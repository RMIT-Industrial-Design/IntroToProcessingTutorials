
void setup()
{
  fullScreen();
  background(20, 100, 230);

  fill(120, 80, 10);
  rectMode(CENTER);
  rect(width/2, height/2+height/4, 50, height/2);

  fill(0, 130, 30);
  ellipse(width/2, height/2, 300, 300); 

  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < 720; i+= 30)
  {
    float r = random(100, 200);
    fill(0, random(100, 200), 30);
    ellipse(sin(i)*r, cos(i)*r, r, r);
  }
  popMatrix();

  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < 720; i+= 30)
  {
    float r = random(50, 200);
    fill(0, random(100, 200), 30);
    ellipse(sin(i)*r, cos(i)*r, r, r);
  }
  popMatrix();
  
  rectMode(CORNER);
  fill(0, 130, 30);
  for(int i = 0;i < width;i+= 10) {
    float h = random(10,100);
    rect(i,height-h,4,h); 
  }
  
}
