import processing.video.*;
Capture video;

// Create shader objects
PShader passThroughShader;
PShader pixelateShader;
PShader blurShader;
PShader rippleShader;
PShader rgbShiftShader;

// Create off sceen textures to render our shaders into
PGraphics passThroughFBO;
PGraphics pixelateFBO;
PGraphics blurFBO;
PGraphics rippleFBO;
PGraphics rgbShiftFBO;

//-------------------------------------
void setup() {
  size(640, 480, P3D);
//  fullScreen(P3D);
  noStroke();
  background(0);

  video = new Capture(this, width, height);
  video.start();

  passThroughShader = loadShader("passThrough.glsl"); // Load our .glsl shader from the /data folder
  passThroughShader.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader
  passThroughFBO = createGraphics(width, height, P3D);
  passThroughFBO.shader(passThroughShader);

  pixelateShader = loadShader("pixelate.glsl");
  pixelateShader.set("iResolution", float(width), float(height), 0); 
  pixelateFBO = createGraphics(width, height, P3D);
  pixelateFBO.shader(pixelateShader);

  blurShader = loadShader("blur.glsl");
  blurShader.set("iResolution", float(width), float(height), 0); 
  blurFBO = createGraphics(width, height, P3D);
  blurFBO.shader(blurShader);

  rippleShader = loadShader("ripple.glsl");
  rippleShader.set("iResolution", float(width), float(height), 0); 
  rippleFBO = createGraphics(width, height, P3D);
  rippleFBO.shader(rippleShader);

  rgbShiftShader = loadShader("chromaticAbberation.glsl");
  rgbShiftShader.set("iResolution", float(width), float(height), 0);
  rgbShiftFBO = createGraphics(width, height, P3D);
  rgbShiftFBO.shader(rgbShiftShader);
  
}

//-------------------------------------
void captureEvent(Capture video) {
  video.read();
}

//-------------------------------------
void updateShaderParams() {
  passThroughShader.set("dryWet", 0.0);
  blurShader.set("blurAmount", 0.0);
  pixelateShader.set("downsample", 0.00);
  rippleShader.set("frequency", 0.00);
  rippleShader.set("waveNum", 0.00);
  rgbShiftShader.set("offset", 0.03);
}

//-------------------------------------
void draw() {
  updateShaderParams();

  passThroughFBO.beginDraw();
  passThroughShader.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  passThroughShader.set("tex", video);
  shader(passThroughShader); 
  passThroughFBO.rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
  passThroughFBO.endDraw();

  pixelateFBO.beginDraw();
  pixelateShader.set("iGlobalTime", millis() / 1000.0);
  pixelateShader.set("tex", passThroughFBO);
  shader(pixelateShader); 
  pixelateFBO.rect(0, 0, width, height); 
  pixelateFBO.endDraw();

  blurFBO.beginDraw();
  blurShader.set("iGlobalTime", millis() / 1000.0); 
  blurShader.set("tex", pixelateFBO);
  shader(blurShader); 
  blurFBO.rect(0, 0, width, height); 
  blurFBO.endDraw();

  rippleFBO.beginDraw();
  rippleShader.set("iGlobalTime", millis() / 1000.0); 
  rippleShader.set("tex", blurFBO);
  shader(rippleShader); 
  rippleFBO.rect(0, 0, width, height); 
  rippleFBO.endDraw();

  rgbShiftFBO.beginDraw();
  rgbShiftShader.set("iGlobalTime", millis() / 1000.0); 
  rgbShiftShader.set("tex", rippleFBO);
  shader(rgbShiftShader); 
  rgbShiftFBO.rect(0, 0, width, height); 
  rgbShiftFBO.endDraw();

  image(rgbShiftFBO, 0, 0, width, height);
}