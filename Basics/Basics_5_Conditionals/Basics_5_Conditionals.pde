//----------------------------------------
void setup() {
  size(500, 500);
  background(0);
}

//----------------------------------------
void draw() {
}

//----------------------------------------
void keyPressed() {
  if (key >= 48 && key <= 57) {
    println("key pressed was a number");
  } else if (key >= 65 && key <= 90) {
    println("key pressed was an uppercase letter");
  } else if (key >= 97 && key <= 122) {
    println("key pressed was a lowercase letter");
  }

  switch (keyCode) {
  case UP:
    println("up key was pressed");
    break;

  case DOWN:
    println("down key was pressed");
    break;

  case LEFT:
    println("left key was pressed");
    break;

  case RIGHT:
    println("right key was pressed");
    break;

  case ALT:
    println("alt key was pressed");
    break;

  case CONTROL:
    println("control key was pressed");
    break;

  case SHIFT:
    println("shift key was pressed");
    break;
  }
}

//----------------------------------------
void mousePressed() {
  if (mouseY < height * 0.5) {
    println("Mouse was clicked in the top half of the window");
  } else {
    println("Mouse was clicked in the bottom half of the window");
  }
}