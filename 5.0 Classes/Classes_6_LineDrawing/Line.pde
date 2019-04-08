class Line
{
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  color c = color(0);

  Line(PVector a, PVector b)
  {
    p1.x = a.x;
    p1.y = a.y;
    
    p2.x = b.x;
    p2.y = b.y;
  }
  
  void draw()
  {
     stroke(c);
     line(p1.x, p1.y, p2.x, p2.y); 
  }
  
}
