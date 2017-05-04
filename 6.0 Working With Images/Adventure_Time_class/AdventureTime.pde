
class AdventureTime {
  PImage img;
  int x, y;
  float rot_speed = 1.0;
  float size = 1.0;
  
  AdventureTime(PImage _pic, int _x, int _y) {
    x = _x;
    y = _y;
    img = _pic;
  }
  void set_size(float _size){
   size = _size; 
  }
  void set_rot_speed(float _speed){
     rot_speed = _speed; 
  }
  void draw(){
    int w = img.width;
    int h = img.height;
    pushMatrix();
    translate(x,y);
    float lfo = map(sin(frameCount*0.005),-1.0,1.0,0.0,360.0);
    rotate(radians((lfo*rot_speed)));
    image(img,0,0,w*size,h*size);
    popMatrix();
  }
}