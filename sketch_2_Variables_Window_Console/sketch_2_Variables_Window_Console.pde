//-------------------------------------
// Below are the different variable types available in Processing
int x = 50; // Ints store whole numbers
float y = 36.6; // Floats are used to store numbers with decimals or fractions of numbers
boolean b = true; // Boolean values can be either 'true' or 'false'
char c = '!'; // Char can only hold a single character
String message = "hello world"; // Strings hold a collection of characters

//-------------------------------------
void setup(){
  // Define the size of our window
  size(640, 480); // Argument 1 = width of canvas; Argument 2 = height of canvas
  
  // Define a background colour 
  background(0, 0, 0); // R,G,B defined between 0 - 255
  
  // Print the values stored in our varibales to the console
  println("x = " + x);
  println("y = " + y);
  println("b = " + b);
  println("c = " + c);
  println("message = " + message);
}

//-------------------------------------
void draw(){
  
}
