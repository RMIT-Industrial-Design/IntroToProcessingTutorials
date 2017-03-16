class CustomCircle {
  PVector pos = new PVector();
  int choice;

  void setup() {
    pos.set(width/2, height/2);
  }

  // We are always gravitating to the right of screen 
  void update() {
    choice = (int)random(10);
    if (choice < 4) pos.x ++;
    if (choice > 4 && choice < 6) pos.y ++;
    if (choice > 6 && choice < 8) pos.x --;
    if (choice > 8 && choice < 10) pos.y --;
  }

  void draw() {
    fill(255);
    ellipse(pos.x, pos.y, 10, 10);
  }
}