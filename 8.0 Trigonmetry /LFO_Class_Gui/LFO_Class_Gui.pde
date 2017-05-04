LFO lfo;

import controlP5.*;
ControlP5 gui;

float sine_freq, tri_freq, sqr_freq, saw_freq = 0.0;

//-------------------------
void setup() {
  size(1024, 768);
  lfo = new LFO();

  gui = new ControlP5(this);
  setup_gui();
}
//-------------------------
void update(){
  lfo.set_sine_freq(sine_freq);
  lfo.set_triangle_freq(tri_freq);
  lfo.set_square_freq(sqr_freq);
  lfo.set_sawtooth_freq(saw_freq);
}

//-------------------------
void draw() {
  update();
  background(0);
  int max_size = 250;
  float radius1, radius2, radius3, radius4;
  radius1 = lfo.get_sine_norm() * max_size;
  radius2 = lfo.get_triangle_norm() * max_size;
  radius3 = lfo.get_square_norm() * max_size;
  radius4 = lfo.get_sawtooth_norm() * max_size;
  int h = height/2;
  ellipse(200, h, radius1, radius1);
  ellipse(400, h, radius2, radius2);
  ellipse(600, h, radius3, radius3);
  ellipse(800, h, radius4, radius4);
}

//------------------------
void setup_gui() {
  Group lfo_group = gui.addGroup("LFOS")
    .setPosition(15, 20)
    .setBackgroundHeight(400)
    .setWidth(200)
    .setBackgroundColor(color(255, 40));

  Textlabel lfoLabel;
  lfoLabel = gui.addTextlabel("lfoLabel")
    .setText("LFO CONTROL!")
    .setPosition(0, 5)
    .setColorValue(0xfffff00)
    .setGroup(lfo_group);

  gui.addSlider("sine_freq")
    .setPosition(5, 30)
    .setRange(0.0, 6.0)
    .setValue(sine_freq)
    .setGroup(lfo_group);

  gui.addSlider("tri_freq")
    .setPosition(5, 45)
    .setRange(0.0, 6.0)
    .setValue(tri_freq)
    .setGroup(lfo_group);

  gui.addSlider("sqr_freq")
    .setPosition(5, 60)
    .setRange(0.0, 6.0)
    .setValue(sqr_freq)
    .setGroup(lfo_group);

  gui.addSlider("saw_freq")
    .setPosition(5, 75)
    .setRange(0.0, 6.0)
    .setValue(saw_freq)
    .setGroup(lfo_group);
}