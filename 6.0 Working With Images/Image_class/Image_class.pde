ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<SineWave> oscillators = new ArrayList<SineWave>();
ArrayList<AdventureTime> finns = new ArrayList<AdventureTime>();

PImage[] imgs = new PImage[3]; 
int adventure_index = 0;

//--------------------
void setup() {
  fullScreen(P2D);
  //  size(1024, 768, P2D);

  imgs[0] = loadImage("Images/Finn.png");
  imgs[1] = loadImage("Images/jake.png");
  imgs[2] = loadImage("Images/IceKing.png");

  for (int i = 0; i < 3; i++) {
    imgs[i].resize(imgs[i].width/3, imgs[i].height/3);
  }
}
//--------------------
void draw() {
  background(0);

  for (int i = 0; i < circles.size(); i++) {
    Circle circle = circles.get(i);
    circle.update();
    circle.draw();

    float amp = map(circle.getAlpha(), 0, 255, 0.0, 0.08);
    SineWave oscillator = oscillators.get(i);
    oscillator.setAmp(amp);
  }

  for (int i = 0; i < finns.size(); i++) {
    AdventureTime finn = finns.get(i);
    float norm_length = map(i, 0, finns.size(), 0.0, 1.0);
    float lfo = map(norm_length*sin(frameCount*0.02), -1.0, 1.0, 0.0, 1.0);
    finn.set_size(lfo);
    finn.set_rot_speed(lfo*0.25);
    finn.draw();
  }
}
//--------------------
void keyPressed() {
  if (key == 'c') {
    for (int i = 0; i < oscillators.size(); i++) {
      SineWave oscillator = oscillators.get(i);
      oscillator.exit();
    }
    oscillators.clear();
    circles.clear();
    finns.clear();
  }

  if (key == '1') adventure_index = 0;
  if (key == '2') adventure_index = 1;
  if (key == '3') adventure_index = 2;
}

//--------------------
void mousePressed() {
  //circles.add(new Circle(mouseX, mouseY));
  finns.add(new AdventureTime(imgs[adventure_index], mouseX, mouseY));
  float frequency = map(mouseX, 0, width, 100, 1000);
  //oscillators.add(new SineWave(this, frequency));
}