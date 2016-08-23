/*------------------------------------------------- 
 Noise Landscape ::
 */

float mult = 0.005;
float z = 0.0;

Mountain m;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(0);
  
  m = new Mountain();
}

//-------------------------------------------------
void update() {
  z+= 0.01;
}

//-------------------------------------------------
void draw() {
  update();

  for (int x = 50; x < width-50; x+= 30) {
    for (int y = 50; y < height-50; y+= 30) {

      float n = noise(x*mult, y*mult, z);
      float w = map(n, 0, 1, 20, 50);
      float h = map(n, 0, 1, 10, 70);
      float alpha = map(n, 0, 1, 0, 255);

      if (n > 0.1) {
        m.drawMountain(x, y, w, h, alpha);
      }
    }
  }
}