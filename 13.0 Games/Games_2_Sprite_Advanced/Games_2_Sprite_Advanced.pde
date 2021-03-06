Sprite sprite; 

void setup()
{
  size(1000, 1000, P3D);
  sprite = new Sprite();
}

void draw()
{
  background(255);

  // draw sky
  fill(135, 206, 235);
  rect(0, 0, width, height/2);

  // draw ground
  fill(34, 69, 0);
  rect(0, height/2, width, height/2);
 
 //draw sprite
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
  case 32:
    sprite.jump();
  break;
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
