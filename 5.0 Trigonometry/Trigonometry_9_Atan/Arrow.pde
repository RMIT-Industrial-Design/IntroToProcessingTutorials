class Arrow {
  PVector pos = new PVector(width/2, height/2);
  PVector diff = new PVector();
  float rot;

  void update(float _x, float _y) {

    PVector newPos = new PVector();
    newPos.set(_x, _y);
    pos = pos.add(pos.mult(0.97), newPos.mult(0.03));

    diff = PVector.sub(newPos, pos);
    rot = atan2(diff.y, diff.x);
    rot = radians(rot);
  }

  void draw() {

    float x1 = 0;
    float y1 = -10;

    float x2 = 0;
    float y2 = 10;

    float x3 = 30;
    float y3 = 0;

    fill(0);
    translate(pos.x, pos.y);
    rotate(rot);
    triangle (x1, y1, x2, y2, x3, y3);
  }
}