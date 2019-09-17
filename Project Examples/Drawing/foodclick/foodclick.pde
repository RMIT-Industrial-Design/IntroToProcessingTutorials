PImage tableImg;
//declare new Class named Button and Brush
int numImages = 10;
PImage images[] = new PImage[numImages];
Button button[] = new Button[numImages];
Brush brush;
Button reset = new Button(440, 900, 150, 50, color(255, 0, 0));

void setup() {
  size(1000, 1000);
  background(255);
  tableImg = loadImage("table top.jpg");

  reset();

  images[0] = loadImage("sausage.png");
  images[1] = loadImage("drumstick.png");
  images[2] = loadImage("egg.png");
  images[3] = loadImage("bacon.png");
  images[4] = loadImage("croissant.png");
  images[5] = loadImage("bagel.png");
  images[6] = loadImage("sandwich.png");
  images[7] = loadImage("baguette.png");
  images[8] = loadImage("lettuce.png");
  images[9] = loadImage("tomato.png");

  button[0] = new Button(75, 75, 80, 160, color(255, 0, 0));
  button[1] = new Button(75, 275, 100, 140, color(255, 0, 255));
  button[2] = new Button(75, 475, 110, 130, color(255, 255, 0));
  button[3] = new Button(75, 675, 80, 190, color(255, 145, 0));
  button[4] = new Button(725, 75, 238, 123, color(255, 145, 0));
  button[5] = new Button(775, 235, 182, 182, color(255, 145, 0));
  button[6] = new Button(775, 445, 182, 210, color(255, 145, 0));
  button[7] = new Button(775, 675, 157, 263, color(255, 145, 0));
  button[8] = new Button(170, 50, 211, 207, color(255, 145, 0));
  button[9] = new Button(470, 50, 98, 109, color(255, 145, 0));

  brush = new Brush();
}

void draw() {

  for (int i = 0; i < numImages; i++)
  {
    button[i].update();
    button[i].display(i);
  }

  reset.update();
  reset.show();

  for (int i = 0; i < numImages; i++)
  {
    if (button[i].clicked == true) {
      brush.setImage(i);
    }
  }
  brush.paint();

  if (reset.clicked == true) {
    reset();
  }
}

void reset()
{
  background(255);
  image(tableImg, 0, 0, width, height);
  ellipse(height/2, width/2, 500, 500);
}

void keyPressed() {
  if (key == 's') {
    selectFolder("proceed to folder", "selectedfolder");
  }
}

//if no folder is selected, no image saved 
void selectedfolder(File selection) {
  if (selection == null) {
    return;
  } else {
    String direction2 = selection.getPath()+"\\";
    save(direction2 + "image.png");
  }
}
