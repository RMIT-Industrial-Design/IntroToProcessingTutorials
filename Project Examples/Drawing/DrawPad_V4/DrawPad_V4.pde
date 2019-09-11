import controlP5.*; // imports controlP5 library for sliders

boolean draw = false;
int numBrushes = 5;
BrushButtons bb[] = new BrushButtons[numBrushes];
Pen pen;
ControlP5 rCon;
int sB;
int sR;
int sG;
int opacity;
int radius;

void setup() {
  size(800, 800);
  imageMode(CENTER);
  rectMode(CENTER);
  fill(255);
  rect(width/2, height - 500, width, 600);

  for (int i = 0; i < numBrushes; i++)
  {
    String name = "Brush" +(i+1)+".png";
    bb[i] = new BrushButtons(width - 60 - 80*i, 740, name);
  }

  pen = new Pen();

  rCon = new ControlP5(this); // adding slider functionality
  rCon.addSlider("sR").setPosition(80, 613).setRange(0, 255).setWidth(200).setHeight(40);
  rCon.addSlider("sG").setPosition(80, 679).setRange(0, 255).setWidth(200).setHeight(40);
  rCon.addSlider("sB").setPosition(80, 745).setRange(0, 255).setWidth(200).setHeight(40);
  rCon.addSlider("opacity").setPosition(width - 410, 610).setRange(5, 30).setWidth(140).setHeight(20).setValue(15);
  rCon.addSlider("radius").setPosition(width - 410, 640).setRange(5, 40).setWidth(140).setHeight(20).setValue(15);
}

void draw() {
  fill(80);
  rect(width/2, height - 100, width, 200); // gui

  tint(0);
  for (int i = 0; i < numBrushes; i++)
  {
    bb[i].update();
    if(bb[i].clicked == true) {
      println("change pen to brush "+(i+1));
      pen.setBrush(i);  
    }
    bb[i].display();
  }

  fill(sR, 0, 0);
  rect(40, 633, 40, 40);
  fill(0, sG, 0);
  rect(40, 699, 40, 40);
  fill(0, 0, sB);
  rect(40, 765, 40, 40);
  noFill();

  if ((mouseY >= 0) && (mouseY <= 600)) { // stops drawings continuing when selecting brushes and sliders
    pen.paint();
  }
}

void mouseDragged() {
  draw = true;
}

void mousePressed() {

}

void keyPressed() { // clears canvas
  if (key == 'c' || key == 'C') {
    fill(255);
    rect(width/2, height - 500, width, 600);
  }
}
