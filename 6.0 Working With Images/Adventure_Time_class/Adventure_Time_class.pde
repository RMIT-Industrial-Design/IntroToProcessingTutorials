ArrayList<AdventureTime> adventures = new ArrayList<AdventureTime>();

PImage[] imgs = new PImage[3];
int pic_index = 0;

boolean bStart = false;

void setup() {
//  size(1024, 768, P2D);
  fullScreen(P2D);

  imgs[0] = loadImage("Images/Finn.png");
  imgs[1] = loadImage("Images/jake.png");
  imgs[2] = loadImage("Images/IceKing.png");
  for (int i = 0; i < 3; i++) {
    imgs[i].resize(imgs[i].width/3, imgs[i].height/3);
  }
}

void draw_splash_screen() {
  // DRAW SOME SPLASH TEXT 
  background(255, 0, 0);
}

void draw() {
  if (bStart == false) {
    draw_splash_screen();
  } else if (bStart == true) {
    background(0);
    for (int i = 0; i < adventures.size(); i++) {
      AdventureTime adventure = adventures.get(i);
      float norm_length = map(i, 0, adventures.size(), 0.0, 1.0);
      float lfo = map(norm_length*sin(frameCount*0.02), -1.0, 1.0, 0.0, 1.0);
      adventure.set_size(lfo);
      adventure.set_rot_speed(lfo*5.25);
      adventure.draw();
    }
  }
}

void mousePressed(){
 bStart = true; 
}

void keyPressed() {
  if (key == '1') pic_index = 0;
  if (key == '2') pic_index = 1;
  if (key == '3') pic_index = 2;
}

void mouseDragged() {
  adventures.add(new AdventureTime(imgs[pic_index], mouseX, mouseY));
}