import processing.serial.*; //import the Serial library
Serial port;    // The serial port, this is a new instance of the Serial class (an Object)

class ArduinoInput {

  int end = 10;   // the number 10 is ASCII for linefeed (end of serial.println), later we will look for this to break up individual messages
  String serial;  // declare a new string called 'serial'. A string is a sequence of characters (data type known as "char")
  float[] sensorValues = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  
  //-----------------------------------------------------
  ArduinoInput(PApplet papp) {

    port = new Serial(papp, Serial.list()[2], 9600); // initializing the object by assigning a port and baud rate (must match that of Arduino)
    port.clear(); // function from serial library that throws out the first reading, in case we started reading in the middle of a string from Arduino
    serial = port.readStringUntil(end); // function that reads the string from serial port until a println and then assigns string to our string variable (called 'serial')
    serial = null;  // initially, the string will be null (empty)

    println(Serial.list());
  }
  //-----------------------------------------------------  
  float[] getSensor(){
     while (port.available () > 0) { //as long as there is data coming from serial port, read it and store it
      serial = port.readStringUntil(end);
    }  

    if (serial != null) { // if the string is not empty, print the following
      String[] a = split(serial, ','); // a new array (called 'a') that stores values into seperate cells (seperated by commas specified in your Arduino program)
      
      for(int i = 0; i < a.length; i++){
        sensorValues[i] = parseFloat(a[i]); // Convert our string values to ints 
      }
    }
    return sensorValues;
  }
}
