import processing.video.*;

Capture video;

//-------------------------------------
void setup() {
  size(640, 480);  
  frameRate(60);

  video = new Capture(this, width, height);
  video.start();
}

//-------------------------------------
void captureEvent(Capture video) {
  video.read();
}

//-------------------------------------
void draw() {
  image(video, 0, 0, width, height);
}

//-------------------------------------
void keyPressed(){
  if(key == 's'){
    saveFrame("data/cam-###.png");
  }  
}
