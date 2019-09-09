
PVector[][] field;
float scale = 20;
int columns;
int rows;
float noiseZ = 0;

void setup() {
  size(800, 800);
  initField();
}

void initField() {
  
  columns = floor(width / scale) + 1;
  rows = floor(height / scale) + 1;
  
  field = new PVector[columns][rows];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < columns; x++) {
      field[x][y] = new PVector(0,0);
    }
  }
}

void updateField() {
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      float density = map(mouseX, 0, width, 2, 50);
      float angle = noise(x/density, y/density, noiseZ) * TWO_PI;
      field[x][y] = PVector.fromAngle(angle);
      
      pushMatrix();
      translate(x*scale, y*scale);
      rotate(angle);
      stroke(255);
      line(0, 0, scale,0);
      popMatrix();      
    }
  }
}

void draw() {
  background(0);
  updateField();
  noiseZ += 0.005;

}
