import ddf.minim.*;
 
Minim minim;
AudioPlayer player;
 
void setup () {
  // Sketch settings
  size(320, 170);
  smooth();
  stroke(100);
   
  minim = new Minim(this);
  // Upload audio file to the object 'player'
  player = minim.loadFile("/Users/josh/Samples/Methlab/Dembreakz-MethLab.mp3");
  // Play audio file
  player.play();
}
 
void draw () {
  background(0);
  // Calculate relative playhead in pieces.
  // This value moves between 0 und 1.
  float playPos = player.position();
  float playLen = player.length();
  float xpos = (playPos / playLen) * width;
  ellipse(xpos, height / 2, 20, 20);
}

void mousePressed () {
  // Relative position of the mouse on the x - axis , relative
  // To the width of the window
  // Multiply by the length of the audio file .
  float pos = ((float) mouseX / width) * player.length ();
  player.cue((int) pos);
}
 
void keyPressed () {
  // Pause and Play on keypress
  if (player.isPlaying ()) {
    player.pause ();
  }else{
    player.play ();
  }
}