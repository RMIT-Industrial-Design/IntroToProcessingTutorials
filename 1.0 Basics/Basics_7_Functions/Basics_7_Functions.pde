
int x = 100;
int y = 70;

//-------------------------------
void setup(){
  
  println("x + y = " + add(x,y) );
  println("x - y = " + subtract(x,y) );
  println("x * y = " + multiply(x,y) );
}

//-------------------------------
void draw(){ 
}

//-------------------------------
void keyPressed(){
  doSomething();  
}
//-------------------------------
void mousePressed(){
  println("random value = " + getRandomNormalisedValue());
}

//-------------------------------
void doSomething(){
  println("DO IT!!!");
}
//-------------------------------
int add(int x, int y){
  return x + y;
}
//-------------------------------
int subtract(int x, int y){
  return x - y;
}
//-------------------------------
int multiply(int x, int y){
  return x * y;
}
//-------------------------------
float getRandomNormalisedValue(){
  return random(0.0,1.0);
}