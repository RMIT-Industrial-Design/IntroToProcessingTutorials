
class Brush
{
  int radius = 20;
  color c = color(0, 0, 255);
  float nextMouseX;
  float nextMouseY;
  float prevMouseX;
  float prevMouseY;

  void paint()
  {
    noStroke();
    fill(c);
    ellipse(mouseX, mouseY, radius, radius);

    int numFill = 100; 
    nextMouseX = mouseX;
    nextMouseY = mouseY;

    float destX = nextMouseX - prevMouseX;
    float destY = nextMouseY - prevMouseY;

    for (int i= 0; i < numFill; i++) {
      ellipse(prevMouseX + (destX/numFill) *i, prevMouseY + (destY/numFill)*i, 20, 20);
    }

    prevMouseX = nextMouseX;
    prevMouseY = nextMouseY;
  }

  void setColour(color col)
  {
    c = col;
  }
  
  void startDrawing()
  {
    prevMouseX = nextMouseX = mouseX;
    prevMouseY = nextMouseY = mouseY;
  }
}
