/*------------------------------------------------- 
 Pulsating Cirlce ::
 */

float posX, posY;
float size;
float increment;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  //setting initial position for our ball to be in the middle of the screen
  posX = width*0.5; //this is the same as dividing by 2!
  posY = height*0.5;

  size = 0;

  //we now have a variable to control how much our circle grows
  increment = 2;
}

//-------------------------------------------------
void update() {
  size += increment;

  int max_size = 300;
  
  if (size >= max_size || size <= 0) {
    increment *= -1;
  }
}

//-------------------------------------------------
void draw() {
  update();

  //let's make our background white
  background(255); //set any color you like here using RGB values or shades of gray using only one alpha value: 0 == black, 255 == white.

  fill(0);
  ellipse(posX, posY, size, size);

  //let's draw to the screen the size of the circle and the increment
  text("size:" + str(size), 10, 20);
  text("increment:" + str(increment), 10, 40);
}