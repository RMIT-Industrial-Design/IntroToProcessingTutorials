// User Variables 
float cellResolution = 3.0;
float smoothingWidth = 0.02;
float circle_res = 7.0;
float warp_amount = 0.04;


// Create a shader object
PShader shaderToy;

ArduinoInput input;
SoundInput sound;

//-------------------------------------
void setup() {
  //size(640, 480, P2D);
  fullScreen(P2D);
  noStroke();
  background(0);

  shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  input = new ArduinoInput(this);
  sound = new SoundInput(this);
  
}

//-------------------------------------
void update_shader_params(){
  float[] sensorValues = input.getSensor();
  
  cellResolution = map(sound.getVolume(),0.0,1.0,1.0,15.0);;//map(sensorValues[0],0,1023,1.0,15.0);
  smoothingWidth = map(sound.getVolume(),0.0,1.0,0.02,0.30);;//map(sensorValues[1],0,1023,0.02,0.3);
  circle_res = map(sound.getVolume(),0.0,1.0,1.0,20.0);
  
  shaderToy.set("cellResolution", cellResolution);
  shaderToy.set("smoothingWidth", smoothingWidth);
  shaderToy.set("circle_res", circle_res);
  shaderToy.set("warp_amount", warp_amount);
}

//-------------------------------------
void draw() {
  
  update_shader_params();

  //shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  //shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  shaderToy.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  shaderToy.set("iMouse", float(mouseX), float(mouseY), 0.0, 0.); // Pass in our mouse coordinates to the shader
    
  shader(shaderToy); 
  rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
}