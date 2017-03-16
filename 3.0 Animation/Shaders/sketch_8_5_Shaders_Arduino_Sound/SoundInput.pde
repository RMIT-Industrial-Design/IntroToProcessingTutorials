// Import the Minim audio framework
import ddf.minim.*;

Minim minim;
AudioPlayer player;

class SoundInput {

  //Constructor
  SoundInput(PApplet papp) {
    // Load Sound file 
    // we pass this to Minim so that it can load files from the data directory
    minim = new Minim(papp);

    // loadFile will look in all the same places as loadImage does.
    // this means you can find files that are in the data folder and the 
    // sketch folder. you can also pass an absolute path, or a URL.
    player = minim.loadFile("/Users/josh/Documents/Processing/IntroToProcessingTutorials/Shaders/sketch_8_4_Shaders/data/melody.wav");

    // play the file from start to finish.
    // if you want to play the file again, 
    // you need to call rewind() first.
    player.play();
  }

  //--------------------------
  void loadFile(String path) {
    player = minim.loadFile(path);
  }

  //--------------------------
  void play() {
    player.play();
  }

  //--------------------------
  float getVolume() {
    for (int i = 0; i < player.bufferSize() - 1; i++) {
      volume = player.left.get(i) + player.right.get(i) / 2;
    }
    return volume;
  }

  float volume;
}