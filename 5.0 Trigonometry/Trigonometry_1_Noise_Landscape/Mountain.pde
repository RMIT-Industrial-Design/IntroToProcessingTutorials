class Mountain {

  void drawMountain(float _x, float _y, float _w, float _h, float _alpha) {
    float x1 = _x - _w/2;
    float y1 = _y;

    float x2 = _x + _w/2;
    float y2 = _y;

    float x3 = _x;
    float y3 = _y - _h;

    fill(_h*4.0, 255, 0, _alpha);
    triangle(x1, y1, x2, y2, x3, y3);
  }
}