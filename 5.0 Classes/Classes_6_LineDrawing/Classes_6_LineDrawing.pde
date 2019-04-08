/* Click the mouse and draw lines */

ArrayList<Line> lines = new ArrayList<Line>();
int numClicks = 0;
PVector a = new PVector();
PVector b = new PVector();
Boolean addLine = false;

void setup()
{
  size(800,800);
}

void draw()
{
  background(255);
  
  if(addLine) {
    Line l = new Line(a,b);
    lines.add(l);
    addLine = false;
    println("Added line. Num lines = "+lines.size());
  }
  
  for(int i = 0; i < lines.size();i++)
  {
    Line l = lines.get(i);
    l.draw();
  }

  if(numClicks == 1) {
    stroke(200,0,0);
    line(a.x,a.y,mouseX,mouseY);
  }
  
}

void mousePressed() {
  numClicks++;
  
  if(numClicks == 1) {
    a.x = mouseX;
    a.y = mouseY;
  } else if(numClicks == 2) {
    b.x = mouseX;
    b.y = mouseY;
    addLine = true;
    numClicks = 0;
  }
  
}
