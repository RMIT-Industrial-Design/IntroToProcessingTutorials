class CustomCircle {
  PVector pos = new PVector();
  int choice;

  void setup() {
    pos.set(width/2, height/2);
  }

  // Try experimenting with how far in a direction the circle should move
  // Can you contain the randomness to the screen boundaries? 
  void update() {
    choice = (int)random(4);
    if (choice == 0) pos.x ++;
    if (choice == 1) pos.y ++;
    if (choice == 2) pos.x --;
    if (choice == 3) pos.y --;
  }

  void draw() {
    fill(255);
    ellipse(pos.x, pos.y, 10, 10);
  }
}