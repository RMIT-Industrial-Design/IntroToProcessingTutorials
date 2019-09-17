Button[][] button;
int xres;
int yres;
int size = 20;

void setup() //the page setup
{
  size(800, 800);
  background(255);

  xres = width/size;
  yres = height/size;

  button = new Button[xres][yres]; //the max amount of buttons
  for (int i = 0; i < xres; i++) { //60 being the amount of squares in each column/row    
    for (int j = 0; j < yres; j++) {
      button[i][j] = new Button(i*size, j*size,size,size);
    }
  }
}
int col = 0;
void draw() {
  for (int i = 0; i < xres; i++) { //making the buttons able to change colou
    for (int j = 0; j < yres; j++) {
      button[i][j].draw();
      if (button[i][j].clicked == true) {
        col+=15;
        col%=270;
        button[i][j].col = color(col);
        button[i][j].draw();

        rect(i*button[i][j].w, j*button[i][j].h, button[i][j].w, button[i][j].h); //size of each square
        fill(col); //allow the change colour
      }
    }
  }
}
