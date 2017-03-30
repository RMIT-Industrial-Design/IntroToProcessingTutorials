/* Video Tiles */ 

import processing.video.*;

Movie movie;

// horizontal and vertical grid count
// take care of the aspect ratio ... here 4:3
int tileCountX = 12;
int tileCountY = 16;
float tileWidth, tileHeight;
int imageCount = tileCountX*tileCountY; 
int currentImage = 0;
int gridX = 0;
int gridY = 0;

//----------------------------------
void setup() {
  size(1024, 1024);
  smooth();
  background(0); 

  // specify a path or use selectInput() to load a video
  // or simply put it into the data folder
  String path = "Pursuit.mov";
  movie = new Movie(this, path);
  movie.play();

  tileWidth = width / (float)tileCountX;
  tileHeight = height / (float)tileCountY;
}

//----------------------------------
void draw() {
  float posX = tileWidth*gridX;
  float posY = tileHeight*gridY;

  // calculate the current time in movieclip
  float moviePos = map(currentImage, 0,imageCount, 0,movie.duration());
  movie.jump(moviePos);
  movie.read();
  image(movie, posX, posY, tileWidth, tileHeight);

  // new grid position
  gridX++;
  if (gridX >= tileCountX) {
    gridX = 0;
    gridY++;
  }

  currentImage++;
  if (currentImage >= imageCount) noLoop();
}