Sprite sprite; 

void setup()
{
  size(800, 800, P3D);
  sprite = new Sprite();
}

void draw()
{
  background(255);

  fill(135, 206, 235);
  rect(0, 0, width, height/2);

  fill(34, 69, 0);
  rect(0, height/2, width, height/2);

  sprite.display();
  sprite.update();
}

void keyPressed()
{
  switch(keyCode) {
  case UP:
    break;
  case DOWN:
    break;    
  case LEFT:
    sprite.moveLeft();
    break;
  case RIGHT:
    sprite.moveRight();
    break;
  }
}

void keyReleased()
{
  switch(keyCode) {
  case UP:
    break;
  case DOWN:
    break;    
  case LEFT:
    sprite.stop();
    break;
  case RIGHT:
    sprite.stop();
    break;
  }
}
