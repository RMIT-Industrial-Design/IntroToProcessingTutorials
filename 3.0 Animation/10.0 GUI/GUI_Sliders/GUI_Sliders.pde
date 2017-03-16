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

//-------------------------------------
void setup() {
  size(800, 500, P3D);
  background(0);
  cp5 = new ControlP5(this);
  createSliders();
}

//-------------------------------------
void draw() {
  background(bg_Red, bg_Green, bg_Blue);
}

//-------------------------------------
void keyPressed() {
  randomColour();
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
    .setText("Background Colour")
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
// This function gets called when the randomColour button is pushed
// We then manually set the slider values to control the RGB background colour
public void randomColour() {
  cp5.getController("bg_Red").setValue((int)random(255));
  cp5.getController("bg_Green").setValue((int)random(255));
  cp5.getController("bg_Blue").setValue((int)random(255));
}