class Button
{
  int x;
  int y;
  int w;
  int h;
  color col = color(255, 255, 255);
  boolean clicked = false;

  Button(int posx, int posy, int sizex, int sizey) {
    x = posx;
    y = posy;
    w = sizex;
    h = sizey;
  }
  void draw()
  {
    if (mousePressed) {
      if ((mouseX > x) && (mouseX < (x+w)) && (mouseY > y) && (mouseY < (y+h)))
      {
        clicked = true;
      }
    } else {
      clicked = false;
      fill(col);
      rect(x, y, w, h);
    }
  }
}
