class Button {
  int w;
  int h;
  int x;
  int y;
  color c;

  Boolean clicked = false;

  Button(int xpos, int ypos, int button_width, int button_height, color col) {  
    x = xpos;
    y = ypos;
    w = button_width;
    h = button_height;
    c = col;
  }

  void update() {
    if (mousePressed) {
      if ((mouseX>x) && (mouseX < (x+w)) && (mouseY > y) && (mouseY < (y+h))) {
        clicked = true;
        println("clicked");
      }
    } else {
      clicked = false;
    }
  }   
  void display(int index)
  {
    imageMode(CORNER);
    image(images[index], x, y, w, h);
  }

  void show() {
    rectMode(CORNER);
    rect(x, y, w, h);
    fill(0);
    text("RESET", x+55, y+30);
    fill(255);
  }
}
