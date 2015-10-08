PImage image1, image2;

int alpha = 255;
int selMode = REPLACE;
String name = "REPLACE";

//-------------------------------------
void setup() {
  size(640, 480, P3D);
  image1 = loadImage("nature.jpg");
  image2 = loadImage("face.jpg");
  noStroke(); 
}

//-------------------------------------
void draw() {
  frame.setTitle("BLEND MODE = " + name);
  alpha = int(map(mouseX, 0, width, 0, 255));

  if(selMode == SUBTRACT || selMode == DARKEST || selMode == MULTIPLY)
  background(255);
  else {
    background(0); 
  }
  
  tint(255,255);
  image(image1, 0, 0, width, height);

  blendMode(selMode);
  tint(255, alpha);
  image(image2, 0, 0, width, height);
}

//-------------------------------------
void mouseReleased(){
  
  if (selMode == REPLACE) { 
    selMode = BLEND;
    name = "BLEND";
  } else if (selMode == BLEND) { 
    selMode = ADD;
    name = "ADD";
  } else if (selMode == ADD) { 
    selMode = SUBTRACT;
    name = "SUBTRACT";
  } else if (selMode == SUBTRACT) { 
    selMode = LIGHTEST;
    name = "LIGHTEST";
  } else if (selMode == LIGHTEST) { 
    selMode = DARKEST;
    name = "DARKEST";
  } else if (selMode == DARKEST) { 
    selMode = EXCLUSION;  
    name = "EXCLUSION";
  } else if (selMode == EXCLUSION) { 
    selMode = MULTIPLY;  
    name = "MULTIPLY";
  } else if (selMode == MULTIPLY) { 
    selMode = SCREEN;
    name = "SCREEN";
  } else if (selMode == SCREEN) { 
    selMode = REPLACE;
    name = "REPLACE";
  }
}