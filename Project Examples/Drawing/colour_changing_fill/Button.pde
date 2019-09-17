class Button
{
  int w = 50;
  int h = 50;
  int x = 100;
  int y = 100;
  color c = color(255, 0, 255); 
  Boolean clicked = false;
  PImage img;

  Button(int  xpos, int ypos, color col, String imagename) {
    x = xpos;
    y = ypos;
    c = col;
    img = loadImage(imagename);
  }

  void update() {
    if (mousePressed) {   
      if ((mouseX > x) && (mouseX < (x+w)) && (mouseY > y) && (mouseY < (y+h)) ) {
        clicked = true;
        // c = color(0, 255, 0);
      } else {
        clicked = false;
      }
    }
  }

  void display()
  {
    image(img, x, y, w, h);
  }

  void setColour(color col) {
    c = col;
  }
}
