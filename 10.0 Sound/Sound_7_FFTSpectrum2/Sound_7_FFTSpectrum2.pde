AudioHandler fft = new AudioHandler();

int []triangleIndx = new int[NUM_EQ_VALS];

void setup()
{
  size(600,600,P3D);
  fft.init(this);
}

void draw() {
  fft.update();
  fft.drawEq2(0,0,240,200);
  //fft.drawEq();

}
