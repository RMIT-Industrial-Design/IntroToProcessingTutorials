/*------------------------------------------------- 
 Many Pulsating Cirlces ::
 */

float size;
float increment;
int max_size;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  size = 0;
  max_size = 50;

  //we now have a variable to control how much our circle grows
  increment = 0.5;
}

//-------------------------------------------------
void update() {
  size += increment;

  if (size >= max_size || size <= 0) {
    increment *= -1;
  }
}

//-------------------------------------------------
void draw() {
  update();

  //let's make our background white
  background(255); //set any color you like here using RGB values or shades of gray using only one alpha value: 0 == black, 255 == white.

  //call your function in draw
  drawCircles(10, 12);
}

//-------------------------------------------------
void drawCircles(int rows, int columns) {
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      fill(0);
      //noFill();
      ellipse(i*(max_size*2), j*(max_size*2), size, size);
    }
  }
}