PImage img;

//-------------------------------------
void setup() {
  size(640, 480);
  img = loadImage("test.png");
}

//-------------------------------------
void draw() {
  image(img, 0, 0, width, height);
}

//-------------------------------------
void keyPressed() {
  if (key == '1') {
      // Load image from a web server
      String url = "http://funny-pics-fun.com/wp-content/uploads/Very-Funny-Animal-Faces-8.jpg";
      img = loadImage(url, "jpg");
  } else if (key == '2') {
      // Load image stored in our data folder
      img = loadImage("test.png");
  }
}

