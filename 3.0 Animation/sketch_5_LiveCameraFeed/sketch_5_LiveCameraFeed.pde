import processing.video.*;

Capture cam;

//-------------------------------------
void setup() {
  size(640, 480);  
  frameRate(60);

  cam = new Capture(this, width, height);
  cam.start();
}

//-------------------------------------
void captureEvent(Capture video) {
  cam.read();
}

//-------------------------------------
void draw() {
  image(cam, 0, 0, width, height);
}

//-------------------------------------
void keyPressed(){
  if(key == 's'){
    saveFrame("data/cam-###.png");
  } 
  
}