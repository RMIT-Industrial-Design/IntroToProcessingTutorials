class customCircle {
  float offset;
  float size;
  float lineWidth;
  
  void setup(float _offset) {
    offset = _offset;
  }

  void update() {
    float sinOfTime = sin((frameCount*0.01)+offset);
    size = map(sinOfTime, -1, 1, 50, 600);
    lineWidth = map(sinOfTime, -1, 1, 0.1, 10);
  }

  void draw() {
    strokeWeight(lineWidth);
    stroke(255);
    ellipse(width/2, height/2, size, size);
  }
}