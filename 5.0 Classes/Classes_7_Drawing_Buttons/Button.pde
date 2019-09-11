class Button
{
  int w = 50;
  int h = 50;
  int x = 100;
  int y = 100;
  color c;
  Boolean clicked = false;
  int type = 1; // type 1 = square, type 2 = circle

  Button(int xpos, int ypos, color col) {
    x = xpos;
    y = ypos;
    c = col;
  }

  void update(Brush b) {
    if (mousePressed) {
      if ((mouseX > x) && (mouseX < (x+w)) && (mouseY > y) && (mouseY < (y+h)) ) {
        clicked = true;
        b.setColour(c);
      }
    } else {
      clicked = false;
    }
  }

  void display()
  {
    if (type == 1) {
      fill(c);
      rect(x, y, w, h);
    } 
    else if (type == 2) {
      fill(c);
      ellipse(x,y,w,h);
    }
  }
}
