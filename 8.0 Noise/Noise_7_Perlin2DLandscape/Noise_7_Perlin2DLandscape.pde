// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/IKB1hWWedMk

int cols, rows;
int div = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cols = w / div;
  rows = h/ div;
  terrain = new float[cols][rows];
}


void draw() {

  background(0);
  stroke(255,0,150);
  noFill();
  
  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*div, y*div, terrain[x][y]);
      vertex(x*div, (y+1)*div, terrain[x][y+1]);
    }
    endShape();
  }
  
}
