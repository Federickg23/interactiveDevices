/**
 * Simple Read
 * 
 * Slightly Modified from the Serial Example provided through the Ardunio IDE
 *
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

void setup() 
{
  //System.out.println(Serial.list());
  size(500, 500);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  System.out.println(portName);
  myPort = new Serial(this, portName, 115200);
}

void draw()
{
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  val = trim(val);
  if (val != null)
    val = val.substring(val.length()-1); 
  System.out.println(val);
  background(255);             // Set background to white
  if (val != null && val.equals("0")) {              // If the serial value is 0,
    fill(0);                   // set fill to black
  } 
  else {                       // If the serial value is not 0,
    fill(204);                 // set fill to light gray
  }
  rect(50, 50, 100, 100);
}



/*
// Wiring / Arduino Code
// Slightly modified from the freenove joystick example
  Filename    : Joystick
  Description : Read data from joystick.
  Auther      : www.freenove.com
  Modification: 2020/07/11
int xyzPins[] = {13, 12, 14};   //x,y,z pins
void setup() {
  Serial.begin(9600);
  pinMode(xyzPins[2], INPUT_PULLUP);  //z axis is a button.
  pinMode(25, INPUT_PULLUP);  //button.
}
void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  //Serial.printf("X,Y,Z: %d,\t%d,\t%d\n", xVal, yVal, zVal);
  //Serial.printf(zVal);
  int buttonVal = digitalRead(25);
  Serial.print(buttonVal);
  Serial.print('\n');
  delay(100);
}
*/
