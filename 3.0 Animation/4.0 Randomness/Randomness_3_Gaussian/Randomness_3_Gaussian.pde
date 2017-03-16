/*------------------------------------------------- 
 Gaussian Noise ::
 */

float x;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(0);
}

//-------------------------------------------------
void update() {
  float num = gaussian();
  float sd = 120;
  float mean = width / 2;
  x = (sd * num) + mean;
}

//-------------------------------------------------
void draw() {
  update();

  fill(255, 100);
  ellipse(x, height/2, 10, 10);
}

//-------------------------------------------------
//code for gaussian taken from: https://github.com/andyr0id/ofxGaussian
Boolean haveNextNextGaussian = false;
float nextNextGaussian;

float gaussian() {
  if (haveNextNextGaussian) {
    haveNextNextGaussian = false;
    return nextNextGaussian;
  } else {
    float v1, v2, s;
    do {
      v1 = 2 * random(1.0) - 1;
      v2 = 2 * random(1.0) - 1;
      s = v1 * v1 + v2 * v2;
    } while (s >= 1 || s == 0);

    float multiplier = sqrt(-2 * log(s)/s);
    nextNextGaussian = v2 * multiplier;
    haveNextNextGaussian = true;

    return v1 * multiplier;
  }
}