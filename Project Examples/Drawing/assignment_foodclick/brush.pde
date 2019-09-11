class Brush {
  PImage img;
  Boolean imageLoaded = false;
  int curImageIndex = 0;

  void paint() {
    if (imageLoaded == true) {
      if (mousePressed) {
        if ((mouseX > 300) && (mouseX < 700) && (mouseY < 700) && (mouseY > 300)) {
          imageMode(CENTER);
          image(images[curImageIndex], mouseX, mouseY);
        }
      }
    }
  }

  void setImage(int index)
  {
    curImageIndex = index;
    imageLoaded = true;
    println("set image = "+index);
  }
}
