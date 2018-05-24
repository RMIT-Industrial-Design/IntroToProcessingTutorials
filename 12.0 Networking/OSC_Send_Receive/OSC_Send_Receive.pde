import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,6666);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


void draw() {
  background(0);  
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */  
  if(theOscMessage.checkAddrPattern("/test")==true) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      int firstValue = theOscMessage.get(0).intValue();  // get the first osc argument
      int secondValue = theOscMessage.get(1).intValue();  // get the first osc argument
     // float secondValue = theOscMessage.get(1).floatValue(); // get the second osc argument
     // String thirdValue = theOscMessage.get(2).stringValue(); // get the third osc argument
      print("### received an osc message /test with typetag ifs.");
      println(" values: "+firstValue);//+", "+secondValue+", "+thirdValue);
      //return;
  }
  println("### received an osc message. with address pattern "+
          theOscMessage.addrPattern()+" typetag "+ theOscMessage.typetag());
}
