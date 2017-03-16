/*------------------------------------------------- 
 Growing Cirlce ::
 */

float posX, posY;
float size;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  //setting initial position for our ball to be in the middle of the screen
  posX = width*0.5; //this is the same as dividing by 2!
  posY = height*0.5;

  //let's start with size 0.
  size = 0;
}

//-------------------------------------------------
void update() {
  //make our circle grow!
  size++; //this is the same as as saying size += 1 or size = size + 1

  //comment the line above and try also other values... 3, 6, 10...
  //size += 10;
}

//-------------------------------------------------
void draw() {
  update();

  //let's make our background white
  background(255); //set any color you like here using RGB values or shades of gray using only one alpha value: 0 == black, 255 == white.

  fill(0); //let's make our ball black

  //below is a set of commands you can uncomment to make things more interesting
  //noFill(); //you guessed it! Draws only the outlines
  //strokeWeight(10.5); //makes the outline thicker or thinner

  ellipse(posX, posY, size, size);

  //let's draw to the screen the size of the circle
  text("size:" + str(size), 10, 20);
}