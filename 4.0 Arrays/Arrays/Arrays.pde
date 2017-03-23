// Arrays 
float[] speeds = new float[3];
color[] colours = new color[4];

int speed_index = 0;
int colour_index = 0;

//----------------------------
void setup() {
  size(1024, 768);

  // We need to define array values in setup
  speeds[0] = 0.1;
  speeds[1] = 10.0;
  speeds[2] = 40.0;

  colours[0] = color(255, 0, 0);
  colours[1] = color(255, 255, 0);
  colours[2] = color(255, 0, 255);
  colours[3] = color(0, 255, 120);
}

//----------------------------
void draw() {
  background(0);

  int radius = (int)(frameCount*speeds[speed_index]) % 300;
  fill(colours[colour_index]);
  ellipse(width*0.5, height*0.5, radius, radius);
}

//----------------------------
void keyPressed() {
  if (key == '1') speed_index = 0;
  if (key == '2') speed_index = 1;
  if (key == '3') speed_index = 2;

  if (key == 'q') colour_index = 0;
  if (key == 'w') colour_index = 1;
  if (key == 'e') colour_index = 2;
  if (key == 'r') colour_index = 3;
}