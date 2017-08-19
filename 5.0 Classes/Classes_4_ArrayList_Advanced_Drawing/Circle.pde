
class Circle{
  int x;
  int y;
  int radius;
  int max_size = 150;
  
  // Constructor
  Circle(int _x, int _y){
    x = _x;
    y = _y;
    radius = 0;
  }
  
  void update(){
    radius++;
  }
  
  void draw(){
    noFill();
    int alpha = (int)map(radius%max_size,0,max_size,255,0);
    stroke(alpha,255-alpha, 255, alpha);
    ellipse(x,y,radius%max_size,radius%max_size);
  }
}