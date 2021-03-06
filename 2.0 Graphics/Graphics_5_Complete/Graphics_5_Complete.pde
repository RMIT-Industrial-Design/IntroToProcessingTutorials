float counter;
//-------------------------------------
void setup() {
  size(900, 280);
  background(0, 0, 0);
  counter = 0.0;
}

//-------------------------------------
void draw() {
  background(255); // Make sure we clear our background each loop through draw()
  // Try commenting out this line to see what happens otherwise.
  counter = counter + 0.033; // Iterate our counter variable 

  int x = 150;
  int y = 100;

  //--------------------------- circles
  //let's draw a circle:
  float radius = 50 + 10 * sin(counter);
  fill(255, 120, 0);    // draw "filled shapes"
  ellipse(x, y, radius, radius);

  // now just an outline
  noFill();
  stroke(255, 100, 220); // Define the colour of the outline 
  strokeWeight(1); // Set the width of the outline
  
  int w = 80;
  int h = 80;
  ellipse(x, y, w, h);
  noStroke(); // Turn off outlines

  // Write text on our canvas
  fill(0x000000);
  text("circle", 125, 200);

  //--------------------------- rectangles
  for (int i = 0; i < 200; i++) {
    int red = (int)random(0, 255);
    int green = (int)random(0, 255);
    int blue = (int)random(0, 255);

    fill(red, green, blue);
    rect(random(250, 350), random(50, 150), random(10, 20), random(10, 20));
  }
  fill(0x000000);
  text("rectangles", 275, 200);

  //---------------------------  transparency
  fill(0, 255, 55);
  rect(400, 50, 100, 100);
  fill(255, 0, 0, 127);   // red, 50% transparent
  rect(450, 130, 100, 33);
  fill(255, 0, 0, (int)(counter * 10.0f) % 255);   // red, variable transparent
  rect(450, 70, 100, 33);

  fill(0x000000);
  text("transparency", 410, 200);

  //---------------------------  lines
  // a bunch of red lines
  smooth();
  for (int i = 0; i < 20; i++) {
    stroke(255, 0, 0);
    line(600, 50 + (i*5), 800, 0 + (i*10));
  }

  fill(0x000000);
  text("lines", 600, 200);
}