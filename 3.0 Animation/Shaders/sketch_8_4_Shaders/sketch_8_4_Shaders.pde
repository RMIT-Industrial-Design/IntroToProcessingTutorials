//My Variables 
float cellResolution = 4.0;
float smoothingWidth = 0.02;
float ring_speed = 10.0;
float fatness = 0.05;

// Create a shader object
PShader shaderToy;

ArduinoInput arduino;
SoundInput sound;

//-------------------------------------
void setup() {
  //size(640, 480, P2D);
  fullScreen(P2D);
  noStroke();
  background(0);

  shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  arduino = new ArduinoInput(this);
  sound = new SoundInput(this);
}

//-------------------------------------
void update_shader_params(){  
  float[] sensorValues = arduino.getSensor();
  
  cellResolution = map(sensorValues[0],0,1023,1.0,15.0);
  ring_speed = map(sensorValues[1],0,1023,0.0,100.0);
  
  fatness = map(sound.getVolume(),0.0,1.0,0.05,1.25);
  
  shaderToy.set("cellResolution", cellResolution);
  shaderToy.set("smoothingWidth", smoothingWidth);
  shaderToy.set("ring_speed", ring_speed);
  shaderToy.set("fatness", fatness);
}

//-------------------------------------
void draw() {  
  shaderToy = loadShader("myShader.glsl"); // Load our .glsl shader from the /data folder
  shaderToy.set("iResolution", float(width), float(height), 0); // Pass in our xy resolution to iResolution uniform variable in our shader

  update_shader_params();

  shaderToy.set("iGlobalTime", millis() / 1000.0); // pass in a millisecond clock to enable animation 
  shaderToy.set("iMouse", float(mouseX), float(mouseY), 0.0, 0.); // Pass in our mouse coordinates to the shader
    
  shader(shaderToy); 
  rect(0, 0, width, height); // We draw a rect here for our shader to draw onto
}