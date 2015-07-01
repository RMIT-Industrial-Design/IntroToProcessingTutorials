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
  float randomPosition = random(0, video.duration());
  video.jump(randomPosition);
}

