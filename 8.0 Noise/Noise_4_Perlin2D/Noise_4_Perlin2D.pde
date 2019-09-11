Boolean bRandom = true;

void setup()
{
  size(300,300);
}

void draw() 
{
  loadPixels();

  if(bRandom) randomNoise();
  else perlinNoise();

  updatePixels();
}

void randomNoise()
{
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      //A random brightness!
      float bright = random(255);
      //float bright = map(noise(x,y),0,1,0,255);
      pixels[x+y*width] = color(bright);
    }
  }
}

void perlinNoise()
{
  
  float xoff = 0.0;
  for (int x = 0; x < width; x++) {
    float yoff = 0.0;
 
    for (int y = 0; y < height; y++) {
      float bright = map(noise(xoff,yoff),0,1,0,255);
      pixels[x+y*width] = color(bright);
      yoff += 0.01;
    }
    xoff += 0.01;
  }  
  
}

void mousePressed()
{
  bRandom = !bRandom; 
}