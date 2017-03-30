// Lets make a circle class!!!! :)
class Circle {
  int x;
  int y;
  int radius;
  int max_size = 200;
  int alpha;
  int speed;

  // Constructor
  Circle(int _x, int _y) {
    x = _x;
    y = _y;
    radius = 0;
    speed = (int)random(5,20);
  }
  
  void update(){
   radius+=speed; 
  }
  
  int getAlpha(){
   return alpha; 
  }

  void draw() {
    noFill();
    alpha = (int)map(radius % max_size, 0, max_size, 255, 0);
    int r = alpha;
    int g = 255-alpha;
    int b = 255;
    
    stroke(r,g,b, alpha);
    ellipse(x, y, radius % max_size, radius % max_size);
  }
}