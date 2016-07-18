int i = 10; // 'i' can be used anywhere in your program

//--------------------------------------------------------------
void setup() {

  println("global scope:" + " i = " + i);

  i = 20;
  println("setup() scope:" + " i = " + i);

  println("for loop scope");
  for (i = 0; i < 4; i++) {
    println("i = " + i);
  }

  println("end of setup() scope: " + "i = " + i );
}

//--------------------------------------------------------------
void draw() {
}

//--------------------------------------------------------------
void keyPressed() {
  int j = 10;
  println("keyPressed j = " + j);
}

//--------------------------------------------------------------
void keyReleased() {
  println("keyReleased for loop scope");
  for (int i = 0; i < 4; i++) {
    int k = i;
    println("k = " + k);
  }
  //println("keyPressed k = " + k);
}