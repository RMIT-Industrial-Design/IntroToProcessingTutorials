int choice = -1;
PFont f;

void setup() {
  size(200,200);
  f = createFont("SourceCodePro-Regular.ttf", 24);
  textFont(f);  
  textAlign(CENTER);    
}


void draw() {
  background(100);

    if (choice == 0) {
    text("HEADS", width/2, height/2);
  } else if (choice == 1) {
    text("TAILS", width/2,height/2);
  }
}

void keyPressed() {
 tossCoin(); 
}

void mousePressed() {
 tossCoin(); 
}

void tossCoin() {
  choice = (int) random(0,2);

}