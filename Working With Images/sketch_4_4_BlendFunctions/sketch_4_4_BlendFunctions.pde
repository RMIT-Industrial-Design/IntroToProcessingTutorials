PImage image1, image2;

int index = 0;
int alpha = 255;
String blendType;

//-------------------------------------
void setup() {
  size(640, 480, P2D);
  image1 = loadImage("nature.jpg");
  image2 = loadImage("face.jpg");
  
  //applyFilters();
}

//-------------------------------------
void draw() {
  frame.setTitle("BLEND MODE = " + blendType);
  alpha = int(map(mouseX, 0, width, 0, 255));

  tint(255,255);
  image(image1, 0, 0, width, height);

  blendMode(index);
  tint(255, alpha);
  image(image2, 0, 0, width, height);
}

//-------------------------------------
void applyFilters(){

  if(index==0){ blendType = "BLEND"; }
  else if(index==1){ blendType = "ADD"; }
  else if(index==2){ blendType = "SUBTRACT"; }
  else if(index==3){ blendType = "DARKEST"; }
  else if(index==4){ blendType = "LIGHTEST"; }
  else if(index==5){ blendType = "DIFFERENCE"; }
  else if(index==6){ blendType = "EXCLUSION"; } 
  else if(index==7){ blendType = "MULTIPLY"; } 
  else if(index==8){ blendType = "SCREEN"; } 
  else if(index==9){ blendType = "REPLACE"; } 
 
}

//-------------------------------------
void keyReleased(){
  
  if(keyCode == UP){ 
    index++;
    if(index == 10) { index = 0; }
  }
  else if(keyCode == DOWN){ 
    index--; 
    if(index == -1) { index = 9; }
  }
  applyFilters();

}

