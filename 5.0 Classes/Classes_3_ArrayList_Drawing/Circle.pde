
class Circle{
  int x;
  int y;
  int radius = 5;
  
  // Constructor
  Circle(int a, int b){
    x = a;
    y = b;
  }
  
  void update(){
    radius++;
  }
  
  void draw(){
    noFill();
    stroke(255,0, 255);
    ellipse(x,y,radius,radius);
  }
}