/*------------------------------------------------- 
 Many Pulsating Cirlces ::
 */

float size;
float increment;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  size = 0;

  //we now have a variable to control how much our circle grows
  increment = 0.5;
}

//-------------------------------------------------
void update() {
  size += increment;

  int max_size = 150;

  if (size >= max_size || size <= 0) {
    increment *= -1;
  }
}

//-------------------------------------------------
void draw() {
  update();

  //let's make our background white
  background(255); //set any color you like here using RGB values or shades of gray using only one alpha value: 0 == black, 255 == white.

  //now, instead of drawing one circle, we'll use a for loop to draw many
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 11; j++) {
      fill(0);
      //noFill();
      ellipse(i*100, j*100, size, size);
    }
  }
  
  //let's draw to the screen the size of the circle and the increment
  text("size:" + str(size), 10, 20);
  text("increment:" + str(increment), 10, 40);
}