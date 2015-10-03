
// Create a shader object
PShader shaderToy;

//-------------------------------------
void setup() {
  size(640, 480, P2D);
  noStroke();
  background(0);

  shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader
}

//-------------------------------------
void draw() {
  shaderToy.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  shaderToy.set("iMouse", float(mouseX), float(mouseY), 0.0, 0.); // Pass in our mouse coordinates to the shader
  shaderToy.set("sepeartion", 0.5+(sin(millis()*0.00003)*0.5)*4.0);
  shader(shaderToy); 
  rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
}

