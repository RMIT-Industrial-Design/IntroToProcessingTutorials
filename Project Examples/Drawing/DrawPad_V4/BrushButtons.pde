class BrushButtons { 
  float x;
  float y;
  int w = 60;
  int h = 60;
  color c = color(255, 0, 0);
  color c2 = color(0, 255, 0);
  color c3 = color(0, 0, 255);
  PImage img;
  Boolean clicked = false;
  Boolean blocked = false;
  //timer parameters
  float curTime = 0;
  float prevTime = 0;
  int interval = 100;


  BrushButtons(int xpos, int ypos, String icon_name) { 
    x = xpos;
    y = ypos;
    img = loadImage(icon_name);
    imageMode(CENTER);
  }

  BrushButtons(int xpos, int ypos, color col, String icon_name) {
    x = xpos;
    y = ypos;
    c = col;
    img = loadImage(icon_name);
    imageMode(CENTER);
  }

  void update()
  {   
    curTime = millis();
    if (((curTime - prevTime) > interval) && (blocked == true)) {
      blocked = false;
    }

    if ((mousePressed) && (!blocked)) {
      if   ((mouseX > x-w/2) && (mouseX < (x+w/2)) && (mouseY > y-h/2) && (mouseY < (y+h/2))) {
        clicked = true;
        blocked = true;
        prevTime = curTime;
      }
    } else { 
      clicked = false;
    }
  }

  void display() {
    noStroke();
    fill(255);
    //fill(180);
    //rect(x, y, 60, 60);
    image(img, x, y, w, h);
  }
}
