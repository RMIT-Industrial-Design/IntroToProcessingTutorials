// We need to add the ControlP5 GUI library
// Click 'sketch' -> 'Import Library' -> 'ControlP5'
// Note: If ControlP5 is not in the list you may need to download it
// fist by clicking 'Add Library' and searching for ControlP5 in the 
// list. 
import controlP5.*;

// Create a ControlP5 Object
ControlP5 cp5;

// Slider variables
int bg_Red = 100;
int bg_Green = 100;
int bg_Blue = 100;

// Knob variables
int size = 90;
int colour = 180;
float rotate = 0.0005;

// Button variables
boolean wireFrame = false;

// Dropdown List variables
boolean drawCube = true;
boolean drawSphere = false;
boolean drawPyramid = false;

//-------------------------------------
void setup() {
  size(800, 500, P3D);
  background(0);
  cp5 = new ControlP5(this);

  createSliders();
  createKnobs();
  createButtons();
  createDropDownList();
}

//-------------------------------------
void draw() {
  background(bg_Red, bg_Green, bg_Blue);

  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(millis()*rotate);
  rotateY(millis()*rotate);
  rectMode(CENTER);
  if (wireFrame == false) {
    fill(colour);
  } else if (wireFrame == true) {
    noFill();
  }
  if (drawCube == true)  box(size);
  else if (drawSphere == true) sphere(size);
  else if (drawPyramid == true) pyramid(size);
  popMatrix();
}

//-------------------------------------
void pyramid(int t) {  
  // this pyramid has 4 sides, each drawn as a separate triangle
  // each side has 3 vertices, making up a triangle shape
  // the parameter " t " determines the size of the pyramid
  beginShape(TRIANGLES);
  
  vertex(-t,-t,-t);
  vertex( t,-t,-t);
  vertex( 0, 0, t);
  
  vertex( t,-t,-t);
  vertex( t, t,-t);
  vertex( 0, 0, t);
  
  vertex( t, t,-t);
  vertex(-t, t,-t);
  vertex( 0, 0, t);
  
  vertex(-t, t,-t);
  vertex(-t,-t,-t);
  vertex( 0, 0, t);
  
  endShape();
}

//-------------------------------------
void createSliders() {

  // Firstly, we create a group that out sliders will bind to. 
  Group sliders = cp5.addGroup("sliders")
    .setPosition(15, 20)
      .setBackgroundHeight(80)
        .setWidth(160)
          .setBackgroundColor(color(255, 40))
            ;

  // Secondly, we will write a label on screen to notify the user what 
  // the sliders control.
  Textlabel SliderLabel;

  SliderLabel = cp5.addTextlabel("sliderLabel")
    .setText("Background Colours")
      .setPosition(0, 5)
        .setColorValue(0xffffff00)
          .setFont(createFont("Georgia", 15))
            .setGroup(sliders);
  ;

  // Next we add horizontal sliders, the value of this slider will be linked
  // to variable 'bg_Red' 
  cp5.addSlider("bg_Red")
    .setPosition(5, 30)
      .setRange(0, 255)
        .setValue(bg_Red)
          .setGroup(sliders);
  ;

  cp5.addSlider("bg_Green")
    .setPosition(5, 45)
      .setRange(0, 255)
        .setValue(bg_Green)
          .setGroup(sliders);
  ;

  cp5.addSlider("bg_Blue")
    .setPosition(5, 60)
      .setRange(0, 255)
        .setValue(bg_Blue)
          .setGroup(sliders);
  ;
}
//-------------------------------------
void createKnobs() {
  // Firstly, we create a group that out knobs will bind to. 
  Group knobs = cp5.addGroup("knobs")
    .setPosition(15, 120)
      .setBackgroundHeight(80)
        .setWidth(160)
          .setBackgroundColor(color(255, 40))
            ;

  // Secondly, we will write a label on screen to notify the user what 
  // the knobs control.
  Textlabel KnobLabel;

  KnobLabel = cp5.addTextlabel("knobLabel")
    .setText("3D Primative Params")
      .setPosition(0, 5)
        .setColorValue(0xffffff00)
          .setFont(createFont("Georgia", 15))
            .setGroup(knobs);
  ;

  // Next we add knobs
  int knobRadius = 15;

  cp5.addKnob("size")
    .setPosition(5, 30)
      .setRange(0, 255)
        .setRadius(knobRadius)
          .setValue(size)
            .setGroup(knobs);
  ;

  cp5.addKnob("colour")
    .setPosition(60, 30)
      .setRange(0, 255)
        .setRadius(knobRadius)
          .setValue(180)
            .setGroup(knobs);
  ;

  cp5.addKnob("rotate")
    .setPosition(115, 30)
      .setRange(0.0, 0.01)
        .setRadius(knobRadius)
          .setValue(rotate)
            .setGroup(knobs);
  ;
}
//-------------------------------------
void createButtons() {
  // Firstly, we create a group that out buttons will bind to. 
  Group buttons = cp5.addGroup("buttons")
    .setPosition(15, 220)
      .setBackgroundHeight(80)
        .setWidth(160)
          .setBackgroundColor(color(255, 40))
            ;

  // Secondly, we will write a label on screen to notify the user what 
  // the sliders control.
  Textlabel ButtonLabel;

  ButtonLabel = cp5.addTextlabel("buttonLabel")
    .setText("Various Toggles")
      .setPosition(0, 5)
        .setColorValue(0xffffff00)
          .setFont(createFont("Georgia", 15))
            .setGroup(buttons);
  ;

  // Here we add a toggle switch
  cp5.addToggle("wireFrame")
    .setPosition(5, 30)
      .setSize(50, 20)
        .setValue(wireFrame)
          .setGroup(buttons);
  ;

  // Here we add a button
  cp5.addButton("randomColour")
    .setPosition(70, 30)
      .setSize(80, 19)
        .setGroup(buttons);
  ;
}
//-------------------------------------
void createDropDownList() {
  // Firstly, we create a group that out drop down list will bind to. 
  Group dropDownList = cp5.addGroup("dropDownList")
    .setPosition(15, 320)
      .setBackgroundHeight(120)
        .setWidth(160)
          .setBackgroundColor(color(255, 40))
            ;

  // Secondly, we will write a label on screen to notify the user what 
  // the dropdownlist control.
  Textlabel DropDownLabel;

  DropDownLabel = cp5.addTextlabel("dropDownLabel")
    .setText("Select Shape")
      .setPosition(0, 5)
        .setColorValue(0xffffff00)
          .setFont(createFont("Georgia", 15))
            .setGroup(dropDownList);
  ;

  // Now we create our drop down list 
  DropdownList ddl;
  // First, configure how we want it to be displayed
  ddl = cp5.addDropdownList("shapes")
    .setPosition(5, 42)
      .setSize(145, 200)
        .setItemHeight(20)
          .setBarHeight(14)
            .setOpen(true)
              .setGroup(dropDownList);

  // Here we add our elements to the drop down list          
  ddl.addItem("CUBE", 0);
  ddl.addItem("SPHERE", 1);
  ddl.addItem("PYRAMID", 2);
}

//-------------------------------------
// This function gets called when the randomColour button is pushed
// We then manually set the slider values to control the RGB background colour
public void randomColour() {
  cp5.getController("bg_Red").setValue((int)random(255));
  cp5.getController("bg_Green").setValue((int)random(255));
  cp5.getController("bg_Blue").setValue((int)random(255));
}

//-------------------------------------
// This function gets called by our DropDownMenu
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    switch((int)theEvent.getGroup().getValue()) {
      case 0:
        drawCube = true;
        drawSphere = false;
        drawPyramid = false;
        break;
      case 1:
        drawCube = false;
        drawSphere = true;
        drawPyramid = false;
        break;
      case 2:
        drawCube = false;
        drawSphere = false;
        drawPyramid = true;
        break;
     }
  }
}

