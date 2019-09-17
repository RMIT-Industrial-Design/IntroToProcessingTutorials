
class SplashScreen
{

  PImage img1;
  float curTime = 0;
  float prevTime = 0;
  float interval = 3000;
  Boolean showSplashscreen = true;

  SplashScreen()
  {
    img1 = loadImage("title.png");
  }

  void update()
  {
    // splash screen using images and time
    if (showSplashscreen == true) {
      image(img1, 0, 0);
    }
    curTime = millis();
    if (showSplashscreen == true) {
      if ((curTime - prevTime) > interval) {
        showSplashscreen = false; 
        tint(255, 255);
        image(img1, 50, 0);
      }
    }
  }
}
