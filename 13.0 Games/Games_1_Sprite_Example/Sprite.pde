class Sprite
{
  ArrayList<PImage> images = new ArrayList<PImage>();
  PImage img;
  PVector pos;
  PVector vel;
  int direction = 1;
  int w, h;
  float speed = 3;
  int frame = 0;
  int numFrames = 4;
  int animationSpeed = 5;

  Sprite()
  {
    for (int i = 0; i < numFrames; i++) {
      PImage p = loadImage("hat-man"+(i+1)+".png");
      images.add(p);
    }

    img = loadImage("hat-man1.png");
    w = img.width;
    h = img.height;
    pos = new PVector(w/2, height/2);
    vel = new PVector(0, 0);
  }

  void display()
  {
    noStroke();
    fill(255);

    pushMatrix();
    translate(pos.x, pos.y);
    if (direction == -1) {
      scale(-1, 1, 1);
      translate(-w, 0);
    }

    beginShape();
    //texture(img);
    texture(images.get(frame));
    vertex(0, 0, 0, 0);
    vertex(w, 0, w, 0);
    vertex(w, h, w, h);
    vertex(0, h, 0, h);
    endShape();
    popMatrix();

    updateFrame();
  }

  void update() {

    pos.add(vel);
  }

  void moveLeft()
  {
    direction = -1;
    vel.x = -speed;
  }

  void moveRight()
  {
    vel.x = speed;
    direction = 1;
  }

  void stop()
  {
    vel.x = 0;
  }

  void updateFrame()
  {
    if (frameCount % animationSpeed == 0) {
      frame++;
      if (frame >= numFrames) frame = 0;
    }
  }
}
