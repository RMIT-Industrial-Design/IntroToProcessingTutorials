
class AdventureTime {
  PImage img;

  int pic_index = 0;
  int x, y;
  float size = 1.0;
  float rot_speed = 1.0;
  
  AdventureTime(PImage _pic, int _x, int _y) {
    x = _x;
    y = _y;
    img = _pic;
  }
  
  void set_size(float _size){
    size = _size;
  }
  void set_rot_speed(float speed){
    rot_speed = speed;
  }

  void draw() {
    int w = img.width;
    int h = img.height;
    pushMatrix();
    translate(x,y);
    rotate(((frameCount*0.1)%360)*rot_speed);
    image(img, 0, 0, w*size, h*size);
    popMatrix();
  }
  
}