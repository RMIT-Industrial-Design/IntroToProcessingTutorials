/*------------------------------------------------- 
 Bouncing Ball ::
 */

float posX, posY;
float speedX, speedY;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  //let's make our background white
  background(255); //set any color you like here using RGB values or shades of gray using only one alpha value: 0 == black, 255 == white.

  //setting initial position for our ball to be in the middle of the screen
  posX = width*0.5; //this is the same as dividing by 2!
  posY = height*0.5;

  //setting random speeds for X and Y axis
  speedX = random(-5.0, 5.0); // Try experimenting with different ranges
  speedY = random(-5.0, 5.0);
}

//-------------------------------------------------
void update() {
  //updating positions according to speed
  posX += speedX; //this is the same as saying posX = posX + speedX
  posY += speedY;

  //making it bounce of the edges... if the position of the ball is beyond the edges, reverse the speed. Introducing || as "or" sign
  if (posX <= 0 || posX >= width) {
    speedX *= -1;
  }

  if (posY <= 0 || posY >= height) {
    speedY *= -1;
  }
}

//-------------------------------------------------
void draw() {
  update();

  fill(0); //let's make our ball black
  ellipse(posX, posY, 10, 10);

  //let's draw to the screen our speeds!
  text("speedX:" + str(speedX), 10, 20);
  text("speedY:" + str(speedY), 10, 40);
}