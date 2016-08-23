
//-------------------------------------
void setup() {
  // put your setup code here, to run once:
  println("setup");
}

//-------------------------------------
void draw() {
  // put your main code here, to run repeatedly:  
  // println("draw");
}

/*            KEY EVENTS             */
//-----------------------------------//
void keyPressed() {
  println("keyPressed: " + key);
}
void keyReleased() {
  println("keyReleased: " + key);
}

/*            MOUSE EVENTS             */
//-------------------------------------//
void mouseMoved() {
  println("mouseMoved: " + "x = " + mouseX + " | y = " + mouseY);
}
void mouseDragged() {
  println("mouseDragged: " + "x = " + mouseX + " | y = " + mouseY);
}
void mousePressed() {
  println("mousePressed: " + "x = " + mouseX + " | y = " + mouseY);
}
void mouseReleased() {
  println("mouseReleased: " + "x = " + mouseX + " | y = " + mouseY);
}