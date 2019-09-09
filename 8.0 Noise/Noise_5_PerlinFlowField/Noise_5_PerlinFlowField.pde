
float[][][] field;
float size = 20;
int columns = 10;
int rows = 5;
float noiseZ = 0;

void setup() {
  size(800, 800);
  resetField();
}

void initField() {
  field = new float[rows][columns][2];
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      field[x][y][0] = 0;
      field[x][y][1] = 0;
    }
  }
}

void calculateField() {
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      float scale = map(mouseX, 0, width, 2, 50);
      float angle = noise(x/scale, y/scale, noiseZ) * PI * 2;
      float len = noise(x/100, y/100, noiseZ);
      field[x][y][0] = angle;
      field[x][y][1] = len;
    }
  }
}

void drawField() {
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      float angle = field[x][y][0];
      float len = field[x][y][1];
      pushMatrix();
      translate(x*size, y*size);
      rotate(angle);
      stroke(255);
      line(0, 0, 0, size * len);
      popMatrix();
    }
  }
}

void resetField() {
  noiseSeed((long)random(100));
  columns = floor(width / size) + 1;
  rows = floor(height / size) + 1;
  initField();
}

void draw() {
  calculateField();
  noiseZ += 0.005;
  background(0);
  drawField();
}
