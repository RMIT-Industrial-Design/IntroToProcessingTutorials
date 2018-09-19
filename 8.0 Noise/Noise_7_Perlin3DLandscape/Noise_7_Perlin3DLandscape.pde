int div = 10; //controls resolution of the grid 
float[][] terrain;
float xSize,ySize;
float increment = 0.03;
float zoff = 0.0;  
float zincrement = 0.01; 
  
void setup(){
  size(800, 800, P3D);
  terrain = new float[width/div][height/div];
  xSize = width/div;
  ySize = height/div;    
}

void draw(){
  background(0);
  lights();
  noStroke();
  
  translate(0, height/2, -height/2);
  rotateX(radians(60));   
 
  noiseDetail(8,0.3);
 
 float yoff = zoff;
  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int y = 0; y < width/div; y++) 
  {
    yoff += increment;    
    float xoff = 0.0;   
    for (int x = 0; x < height/div; x++) 
    {
      xoff += increment;
      terrain[x][y] = noise(xoff,yoff,zoff)*600;
    }
  }

  for (int x=0; x < xSize -1; x++)
  {
    for(int y=0; y < ySize -1; y++)
    {
      if(mousePressed) {
        fill((terrain[x][y]), 255, 0);
      } else {
        noFill();
        stroke(255,0,150);
      }
      
      beginShape();
      vertex(x*div, y*div, terrain[x][y]);
      vertex( x*div+div, y*div, terrain[x+1][y]);
      vertex(x*div+div, y*div+div, terrain[x+1][y+1]);
      vertex(x*div, y*div+div,terrain[x][y+1]);
      endShape(CLOSE);
    }
  }
  
  zoff -= zincrement;
}
