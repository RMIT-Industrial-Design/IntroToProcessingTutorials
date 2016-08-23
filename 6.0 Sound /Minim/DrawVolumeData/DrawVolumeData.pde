import ddf.minim.*;
 
Minim minim;
AudioPlayer player;

//------------------------------------ 
void setup() {
  size(320, 240);
  noStroke();
   
  // load and play audio file
  minim = new Minim(this);
  player = minim.loadFile("/Users/josh/Samples/Methlab/Dembreakz-MethLab.mp3");
  player.play();
}
 
//------------------------------------ 
void draw() {
  // Create a semi transperent background for trail effects
  fill(0,30);
  rectMode(CORNER);
  rect(0, 0, width, height);
   
  // get the value of the audio
  float dimension = player.mix.level () * 250;
   
  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, dimension, dimension);
}