

float t = 0;

void setup() {
  size(600,400);
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  float n = noise(t);


  // Using map() to customize the range of Perlin noise
  float x = map(n,0,1,0,width);
  ellipse(x,180,30,30);
 
  t += 0.01;
}