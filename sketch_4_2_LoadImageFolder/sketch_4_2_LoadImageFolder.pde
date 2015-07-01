int maxImages = 12; // Total # of images
int imageIndex = 0; // Initial image to be displayed is the first

PImage[] images = new PImage[maxImages];

//-------------------------------------
void setup() {
  size(640, 480);

  for (int i = 0; i < images.length; i++) {
    images[i] = loadImage("beer" + i + ".jpg");
  }
}

//-------------------------------------
void draw() {
  image(images[imageIndex], 0, 0, width, height);
}

//-------------------------------------
void keyPressed() {
  if (keyCode == RIGHT) {
    // Cycle forward
    if (imageIndex >= images.length-1) {
      imageIndex = 0;
    } else {
      imageIndex += 1;
    }
  } else if (keyCode == LEFT) {
    // Cycle backwards
    if (imageIndex <= 0) {
      imageIndex = images.length-1;
    } else {
      imageIndex -= 1;
    }
  }
}

