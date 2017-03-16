/*------------------------------------------------- 
 Basic Primative Drawing ::
 
 Example outling the following methods
 - background();
 - fill();
 - noFill();
 - rect();
 - ellipse();
 - triangle();
 - rectMode();
 - stroke();
 - strokeWeight();
*/

//-------------------------------------------------
void setup() {
  size(1024, 768);
}

//--------------------------------------------------
void draw() {
  // Solid Colour in RGB
  background(0, 120, 80);

  // Solid color in Hexadecimal
  // background(0x00ff00);

  //------------ Circles
  // Bright red
  fill(255, 0, 0);
  ellipse(width/2, 270, 230, 230);

  // Dark red
  fill(127, 0, 0);
  ellipse(510, 80, 100, 100);

  //------------ Rectangles
  // Pink (pale red)
  fill(255, 200, 200);
  rectMode(CORNER);
  rect(width/2, 450, 300, 100);

  // Light Blue
  fill(0, 200, 250);
  rectMode(CENTER);
  rect(width/2, 650, 300, 100);

  //------------ Triangles
  noFill();
  strokeWeight(5);
  stroke(255, 0, 255);
  //Syntax = triangle(x1, y1, x2, y2, x3, y3)
  triangle(80, 475, 158, 320, 236, 475);

  // Reset Global State
  strokeWeight(0);
}