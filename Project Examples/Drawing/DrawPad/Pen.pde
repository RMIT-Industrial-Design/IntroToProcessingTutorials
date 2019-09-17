class Pen {
  PImage img[];
  float nextMouseX;
  float nextMouseY;
  float prevMouseX;
  float prevMouseY;
  int currentBrush = 4;

  Pen() {
    img = new PImage[numBrushes];
    for (int i = 0; i < numBrushes; i++)
    {
      String name = "Brush" +(i+1)+".png";
      img[i] = loadImage(name);
    }
  }

  void paint() {
    if (draw == true) {
      noStroke();
      tint(sR, sG, sB, opacity);
      image(img[currentBrush], mouseX, mouseY, radius, radius);
      float nextMouseX = mouseX;
      float nextMouseY = mouseY;  
      int numFill = 10;
      float destX = nextMouseX - prevMouseX;
      float destY = nextMouseY - prevMouseY;
      for (int i = 0; i < numFill; i++) {
        image(img[currentBrush], prevMouseX + (destX/numFill) * i, prevMouseY + (destY/numFill) * i, radius, radius);
      }
      prevMouseX = nextMouseX;
      prevMouseY = nextMouseY;
      draw = false;
    } else {
      /** FIX **/
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    }
  }
  
  void setBrush(int brushNum)
  {
     currentBrush = brushNum;
     if(currentBrush >= numBrushes) currentBrush = numBrushes-1;
     if(currentBrush < 0) currentBrush = 0;
  }

  //void select() {
  //  if (mousePressed) {
  //    if ((mouseX <= width - 30 && mouseX >= width - 90) && (mouseY <= 770 && mouseY >= 710)) {
  //      img = loadImage("Brush1.png");
  //    }
  //  }
  //  if (mousePressed) {
  //    if ((mouseX <= width - 110 && mouseX >= width - 170) && (mouseY <= 770 && mouseY >= 710)) {
  //      img = loadImage("Brush2.png");
  //    }
  //  }
  //  if (mousePressed) {
  //    if ((mouseX <= width - 190 && mouseX >= width - 250) && (mouseY <= 770 && mouseY >= 710)) {
  //      img = loadImage("Brush3.png");
  //    }
  //  }
  //  if (mousePressed) {
  //    if ((mouseX <= width - 270 && mouseX >= width - 330) && (mouseY <= 770 && mouseY >= 710)) {
  //      img = loadImage("Brush4.png");
  //    }
  //  }
  //  if (mousePressed) {
  //    if ((mouseX <= width - 350 && mouseX >= width - 510) && (mouseY <= 770 && mouseY >= 710)) {
  //      img = loadImage("Brush5.png");
  //    }
  //  }
  //}
}
