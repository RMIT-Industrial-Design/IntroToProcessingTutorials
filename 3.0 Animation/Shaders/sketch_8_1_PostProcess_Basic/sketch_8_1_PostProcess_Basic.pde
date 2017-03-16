// Import the Processing Video Library 
import processing.video.*;
Capture video;

// Create a shader object
PShader passThroughShader;

// Create an off sceen texture to render our shader into
PGraphics passThroughFBO;

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
}

//-------------------------------------
void captureEvent(Capture video) {
  video.read();
}

//-------------------------------------
void updateShaderParams() {
  passThroughShader.set("dryWet", 1.0);
}

//-------------------------------------
void draw() {
  passThroughShader = loadShader("passThrough.glsl"); // Load our .glsl shader from the /data folder
  passThroughShader.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  updateShaderParams();

  passThroughFBO.beginDraw();
  passThroughShader.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  passThroughShader.set("tex", video);
  shader(passThroughShader); 
  passThroughFBO.rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
  passThroughFBO.endDraw();

  image(passThroughFBO, 0, 0, width, height);
}