ArrayList<Circle> circles = new ArrayList<Circle>();

void setup(){
  size(1024,768,P2D);
}

void draw(){
  background(0);
  
  for(int i = 0; i < circles.size(); i++){
    Circle circle = circles.get(i);
    circle.update();
    circle.draw();  
  }
}

void keyPressed(){
  if(key == 'c'){
      circles.clear();
  }
}

void mouseDragged(){
  circles.add(new Circle(mouseX, mouseY));
}