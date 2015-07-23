PImage originalImg;
PImage[] processedImages = new PImage[7];

int index = 0;
String imagePath;
String filterType;

//-------------------------------------
void setup() {
  size(640, 480);
  imagePath = "test.png";
  originalImg = loadImage(imagePath);
  
  applyFilters();
}

//-------------------------------------
void draw() {
  frame.setTitle("FILTER = " + filterType);
  //applyFilters();

  image(processedImages[index], 0, 0, width, height);
}

//-------------------------------------
void applyFilters(){
  for(int i=0; i < 7; i++){
    processedImages[i] = originalImg;
  }
  
  if(index==0){ processedImages[0].filter(BLUR,2); filterType = "BLUR"; }
  else if(index==1){ processedImages[1].filter(POSTERIZE,2); filterType = "POSTERIZE"; }
  else if(index==2){ processedImages[2].filter(ERODE); filterType = "ERODE"; }
  else if(index==3){ processedImages[3].filter(DILATE); filterType = "DILATE"; }
  else if(index==4){ processedImages[4].filter(INVERT); filterType = "INVERT"; }
  else if(index==5){ processedImages[5].filter(THRESHOLD,0.1); filterType = "THRESHOLD"; }
  else if(index==6){ processedImages[6].filter(GRAY); filterType = "GRAY"; } 
}

//-------------------------------------
void keyReleased(){
  
  if(keyCode == UP){ 
    index++;
    if(index == 7) { index = 0; }
  }
  else if(keyCode == DOWN){ 
    index--; 
    if(index == -1) { index = 6; }
  }
  println(index);
  originalImg = loadImage(imagePath);
  applyFilters();

}
//-------------------------------------
void keyPressed() {
  if (key == '1') {
      // Load image from a web server
      imagePath = "http://funny-pics-fun.com/wp-content/uploads/Very-Funny-Animal-Faces-8.jpg";
      originalImg = loadImage(imagePath, "jpg");
      applyFilters();
  } else if (key == '2') {
      // Load image stored in our data folder
      imagePath = "test.png";
      originalImg = loadImage(imagePath);
      applyFilters();
  }
}

