import processing.video.*;
Capture video;

// Create a shader object
PShader passThroughShader;
PShader pixelateShader;

PGraphics passThroughFBO;
PGraphics pixelateFBO;


//-------------------------------------
void setup() {
  size(640, 480, P3D);
  noStroke();
  background(0);

  video = new Capture(this, width, height);
  video.start();

  passThroughShader = loadShader("passThrough.glsl"); // Load our .glsl shader from the /data folder
  passThroughShader.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader
  passThroughFBO = createGraphics(width, height, P3D);
  passThroughFBO.shader(passThroughShader);

  pixelateShader = loadShader("pixelate.glsl");
  pixelateShader.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader
  pixelateFBO = createGraphics(width, height, P3D);
  pixelateFBO.shader(pixelateShader);
}

//-------------------------------------
void captureEvent(Capture video) {
  video.read();
}

//-------------------------------------
void draw() {
  //pixelateShader = loadShader("pixelate.glsl"); // Load our .glsl shader from the /data folder
  //pixelate.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  passThroughFBO.beginDraw();
  passThroughShader.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  passThroughShader.set("tex", video);
  shader(passThroughShader); 
  passThroughFBO.rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
  passThroughFBO.endDraw();


  pixelateFBO.beginDraw();
  pixelateShader.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  pixelateShader.set("tex", passThroughFBO);
  shader(pixelateShader); 
  pixelateFBO.rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
  pixelateFBO.endDraw();

  image(pixelateFBO, 0, 0, width, height);
}

