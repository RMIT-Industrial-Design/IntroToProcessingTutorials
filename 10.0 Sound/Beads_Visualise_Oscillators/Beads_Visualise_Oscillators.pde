BinauralBeats binaural;
int size = 800;

void setup() {
  size(700, 700);
  binaural = new BinauralBeats();
}

void draw() {
  //scan across the pixels
  float volume = binaural.get_master_volume();
  float carrier = binaural.get_carrier_phase();
  float difference = binaural.get_difference_phase();

  binaural.set_frequency(map(mouseX, 0, width, 100.0, 200.0));
  binaural.set_difference(map(mouseY, 0, height, 0.0, 20.0));

  float diff_phase = map(difference, 0.0, 1.0, 0, 255);
  background(diff_phase);
  noFill();
  rectMode(CENTER);
  strokeWeight(40);
  stroke(0, 255, 0, diff_phase);
  ellipse(width/2, height/2, difference*size, difference*size);
}