// Import the video library into Processing
import processing.video.*; 

// Declare a new Movie object
Movie video;

//-------------------------------------
void setup() {
  size(640, 480);
  video = new Movie(this, "dance_loop.mov");
  //  video.play();
  video.loop();
  video.speed(1);
}

//-------------------------------------
void movieEvent(Movie video) {
  video.read();
}

//-------------------------------------
void draw() {
  image(video, 0, 0, width, height);
}

//-------------------------------------
void keyPressed() {
  if (key == 'r') {
    float randomPosition = random(0, video.duration());
    video.jump(randomPosition);
  }
  
  if (key == 's') video.pause();
  else if (key == ' ') video.play();
}

//-------------------------------------
void mouseMoved() {
  float speed = map(mouseX, 0, width, 0.0, 2.0);
  video.speed(speed);
}

