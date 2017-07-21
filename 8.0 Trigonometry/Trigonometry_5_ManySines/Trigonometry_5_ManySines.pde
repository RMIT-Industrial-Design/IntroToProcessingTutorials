/*------------------------------------------------- 
 Many Sines ::
 */

float alpha;
float size;
ArrayList<customCircle> circleList;

//-------------------------------------------------
void setup() {
  size(1024, 768);

  circleList = new ArrayList<customCircle>();
  int num_circles = 10;
  for (float i = 0; i < num_circles; i++) {
    customCircle myCirc = new customCircle();
    myCirc.setup(i/5);
    circleList.add(myCirc);
  }
}

//-------------------------------------------------
void update() {
  for (int i = 0; i < circleList.size(); i++) {
    customCircle circle = circleList.get(i);
    circle.update();
  }
}

//-------------------------------------------------
void draw() {
  update();
  background(20);
  noFill();
  for (int i = 0; i < circleList.size(); i++) {
    customCircle circle = circleList.get(i);
    circle.draw();
  }
}