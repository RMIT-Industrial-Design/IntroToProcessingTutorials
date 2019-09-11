int boxsize = 50;
int cols, rows;
color[][] colors;
int numColors = 5;
color currentColour = color(255, 255, 255);
color palette[] = new color[numColors];
Boolean showGrid = true;

int numButtons = 6;
Button button[] = new Button[numButtons]; 

// splash screen
SplashScreen splashScreen;




void setup()
{  
  size(1000, 1000);

  // Grid using coloms and rows
  cols = width/boxsize;
  rows = height/boxsize;
  colors = new color[cols][rows];

  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      colors[i][j] = color(255); // set each grid(rect) white
    }
  }

  //Buttons using colour and images imported from the buttom class
  button[0] = new Button(1, 100, color(0, 0, 255), "bucketblue.png");
  button[1] = new Button(1, 150, color(255, 0, 0), "bucket.red.png");
  button[2] = new Button(1, 200, color(0, 0, 0), "bucket.black.png");
  button[3] = new Button(1, 250, color(0, 255, 0), "bucket.green.png");  
  button[4] = new Button(1, 300, color(255, 255, 255), "bucket.yellow.png");
  button[5] = new Button(0, 350, color(255, 255, 255), "stroke.png");

  palette[0] = color(0, 0, 255);
  palette[1] = color(255, 0, 0);
  palette[2] = color(0, 0, 0);
  palette[3] = color(0, 255, 0);
  palette[4] = color(244, 232, 104);

  currentColour = palette[0];
  colors[0][2] = color(currentColour);
  splashScreen = new SplashScreen();
}

void draw()
{
  if (splashScreen.showSplashscreen == false) {

    // draw grid 
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int x = i * boxsize;
        int y = j * boxsize;
        if (mouseX > x && mouseX < (x + boxsize) && mouseY > y && mouseY < (y + boxsize)) {
          if (mousePressed && (mouseButton == LEFT)) { // left click to paint
            colors[i][j] = color(currentColour);
          } else if (mousePressed && (mouseButton == RIGHT)) { // right click to "erase"
            colors[i][j] = color(255, 255, 255); 
          }
        }

        fill(colors[i][j]);
        if (showGrid) {
          stroke(0); //stroke of rects
        } else {
          stroke(255);
        }
        rect(x, y, boxsize, boxsize);
      }
    }

    // handle buttons 
    for (int i = 0; i < numButtons; i++)
    {
      button[i].update();
      button[i].display();
    }

    // update colour
    for (int i = 0; i < numColors; i++)
    {
      if (button[i].clicked == true) {
        currentColour = palette[i];
      }
    }

    // enable or disable grid
    if (button[5].clicked == true) 
    {
      showGrid = false;
    } else {
      showGrid = true;
    }
  }

  //splash
  splashScreen.update();
}
