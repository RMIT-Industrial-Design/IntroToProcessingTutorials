
PVector[][] field;
float scale = 20;
int rows;
int columns;
float noiseZ = random(1000);
ArrayList<Particle> particles;
Boolean bRenderParticles = false;

void setup() {
  size(800, 800);
  background(0);
  reset();
}

void initField() {
  field = new PVector[columns][rows];
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      field[x][y] = new PVector(0, 0);
    }
  }
}

void calculateField() {
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      float divider = map(mouseX, 0, width, 2, 50);
      float angle = noise(x/divider, y/divider, noiseZ) * TWO_PI;
      field[x][y] = PVector.fromAngle(angle);
      field[x][y].setMag(1);

      //now draw the field vector
      if (bRenderParticles)
      {
        pushMatrix();
        translate(x*scale, y*scale);
        rotate(angle);
        stroke(255);
        line(0, 0, scale, 0);
        popMatrix();
      }
    }
  }
}

void reset() {
  noiseSeed((long)random(200));
  columns = floor(width / scale)+1;
  rows = floor(height / scale)+1;
  initField();
  initParticles();
}

void initParticles()
{
  particles = new ArrayList<Particle>();
  int numberOfParticles = (width * height) / 1500;
  for (int i = 0; i < numberOfParticles; i++) {
    Particle particle = new Particle();
    particles.add(particle);
  }
}

void drawParticles() {
  for (int i = 0; i < particles.size(); i++)
  {
    Particle p = particles.get(i);
    if (bRenderParticles) {
      p.drawParticle();
    } else { 
      p.drawTrails();
    }
    p.followField();
    p.update();
    p.wrap();
  }
}

void keyPressed()
{
  if (key == ' ') {
    background(0);
    bRenderParticles = !bRenderParticles;
  }
}

void draw() {
  if (bRenderParticles) {
    background(0);
    colorMode(RGB, 255);
  } else {
    colorMode(HSB, 255);
  }
  calculateField();
  noiseZ += 0.005;
  drawParticles();
}
