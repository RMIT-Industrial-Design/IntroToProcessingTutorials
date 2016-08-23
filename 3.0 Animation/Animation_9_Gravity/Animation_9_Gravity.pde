/*------------------------------------------------- 
 Gravity ::
 */

float posX, posY;
float speedX, speedY;
float gravity;

//-------------------------------------------------
void setup() {
  size(1024, 768);
  background(random(127,255));
  
  posX = random(width);
  posY = random(height);

  speedX = random(5, 10);
  speedY = random(-5, -10);

  gravity = 0.5;
}

//-------------------------------------------------
void update() {
  posX += speedX;
  posY += speedY;

  speedY += gravity;

  if (posX <= 0 || posX >= width) {
    speedX *= -0.95;
  }

  if (posY <= 0) {
    speedY *= -1;
  }

  if (posY >= height) {
    posY = height;
    speedY *= -0.9;
  }
}

//-------------------------------------------------
void draw() {
  update();
  
  fill(0);
  ellipse(posX, posY, 10, 10);
}