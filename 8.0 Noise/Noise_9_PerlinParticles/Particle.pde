class Particle {
  PVector accel;
  PVector vel;
  PVector pos;
  int size = 8;
  float hue = 0;

  Particle() 
  {
    pos = new PVector(random(width), random(height) );    
    vel = new PVector(0, 0);
    accel = new PVector(0, 0);
  }

  void update() {
    vel.add(accel);
    pos.add(vel);
    vel.limit(2);
    accel.mult(0);
  }

  void drawParticle() {
    noStroke();
    fill(0, 255, 0);
    rect(pos.x, pos.y, size, size);
  }

  void drawTrails() {
    noStroke();
    hue += 0.4f;
    fill(hue, 128, 128, 40);
    ellipse(pos.x, pos.y, 2, 2);
  }

  void followField() {
    PVector index = new PVector(0, 0);
    index.x = floor(pos.x/scale);
    index.y = floor(pos.y/scale);

    PVector v  = new PVector();
    // if (index.x >= 0 && index.x < (columns+1) && index.y >= 0 && index.y < (rows+1)) {
    v = field[(int)index.x][(int)index.y];
    // }

    //apply force to particle
    accel.add(v);
  }

  void wrap() {
    if (pos.x > width) {
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width - 1;
    }
    if (pos.y > height) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height - 1;
    }
  }
}
