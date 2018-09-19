float t = 0;

void setup()
{
  size(600,600);   
  noiseDetail(1,0.8); //this determines the 'look' of the noise
}

void draw() 
{
  loadPixels();
  perlinNoise();
  updatePixels();
  
  t += 0.01;
}

void perlinNoise()
{
  
  float xoff = 0.0;
  for (int x = 0; x < width; x++) {
    float yoff = 0.0;
 
    for (int y = 0; y < height; y++) {
      float bright = map(noise(xoff,yoff,t),0,1,0,255);
      pixels[x+y*width] = color(bright*3); //multiply by 3 to increase brightness
      yoff += 0.01;
    }
    xoff += 0.01;
  }  
  
}
