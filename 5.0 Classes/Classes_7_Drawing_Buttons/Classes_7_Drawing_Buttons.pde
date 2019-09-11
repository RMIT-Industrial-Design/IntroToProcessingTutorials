int numButtons = 2;
Boolean penDown = false;
Button button[] = new Button[numButtons];
Brush brush;

void setup()
{
  size(800, 800);
  background(255);

  button[0] = new Button(20, height-80, color(0, 255, 255));
  button[1] = new Button(100, height-80, color(255, 0, 255));
  brush = new Brush();
}

void draw()
{
  fill(0);
  rect(0, height-150, width, 150);
  for (int i = 0; i < numButtons; i++)
  {
    button[i].update(brush);
    button[i].display();
  }

  if (penDown) {
    brush.paint();
  }
}

void mousePressed()
{
  penDown = true;
  brush.startDrawing();
}

void mouseReleased()
{
  penDown = false;
}
