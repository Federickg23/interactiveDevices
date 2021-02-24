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
import java.util.Arrays;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
PFont f;

String d20; 
String d12;
String d6;
String[] dSides = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13","14","15","16","17","18","19","20"};

int d20Height;
int d12Height;
int d6Height;

int selected = 0; 
int prevSwitch = 0;
int prevZ = 1; 
int prevB1 = 0; 
int prevB2 = 0; 
boolean instructions = false; 
boolean change; 

int count = 0;

void setup() 
{
  
  //System.out.println(Serial.list());
  size(800, 600);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  System.out.println(portName);
  myPort = new Serial(this, portName, 115200);
  f = createFont("Source Code Pro", 24);
  textFont(f);

  // Create the font
  printArray(PFont.list());
  f = createFont("Source Code Pro", 24);
  textFont(f);
  
  d20 = "20";
  d12 = "12";
  d6 = "6";

  d20Height = height/2;
  d12Height = height/2;
  d6Height = height/2;
}

void draw()
{
 
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  val = trim(val);
  if (val != null){
    String[] temp = val.split(","); 
    int[] values = new int[temp.length];
    for(int i = 0; i < temp.length; i++){
       values[i] = Integer.parseInt(temp[i]);  
       System.out.print(values[i] + ",");
    }
    System.out.println();
    
    background(205, 188, 122);             // Set background to white
    // X = [0] Y = [1] Z = [2] b1 = [3] b2 = [4] switch = [5]; 
    System.out.println(selected); 
    System.out.println(prevSwitch);
    
    if(prevZ == 1 && values[2] == 0){
       instructions = !instructions;  
    }
    
    if(prevB2 == 0 && values[4] == 1){
        d20 = "20";
        d12 = "12";
        d6 = "6";
      
        d20Height = height/2;
        d12Height = height/2;
        d6Height = height/2;
        change = false;
        count = 0; 
        instructions = false; 
        
        selected = 0; 
        prevSwitch = 0;
        prevZ = 1; 
        prevB1 = 0; 
        prevB2 = 0; 
        
    }
    
    if(values[1] > 2000) {
       if(selected == 0){
         d20Height++; 
       }
       else if ( selected == 1){
         d12Height++; 
       }
       else {
        d6Height++; 
       }
    }
    else if (values[1] < 1000){
      if(selected == 0){
         d20Height--; 
       }
       else if ( selected == 1){
         d12Height--; 
       }
       else {
        d6Height--; 
       }
    }
    
    if(values[0] > 2000 && values[5] != prevSwitch){
      selected +=1;
      if (selected > 2){
        selected = 0;
      }
    }
    if(values[0] < 1000 && values[5] != prevSwitch){
      selected -=1;
      if (selected < 0){
        selected = 2;
      }
    }
    if(prevB1 == 0 && values[3] ==1){
     change = true;  
    }
    prevSwitch = values[5];
    prevZ = values[2];
    
    if(change){
       count ++ ;  
    }
    
    dice(); 
    if(instructions)
      instructionText(); 
  }
  
  System.out.println(count); 
}

void dice(){
  
  //background(102);
  
  pushMatrix();
  translate(width*0.2, d20Height);
  //rotate(frameCount);
  rotate(3*PI/2);
  fill(255,255,255);
  if(selected == 0){
    fill(255, 255, 0);
    if(count > 0){
       if (count % 7 == 0){
         d20 = dSides[(int)(Math.random()*20)];
       }
    } 
    if(count > 100){
       count = 0; 
       change = false; 
    }
  }
  polygon(0,0,70,6);
  polygon(0,0, 40, 3); 
  popMatrix(); 
  
  pushMatrix();
  translate(width*0.5, d12Height);
  //rotate(frameCount);
  rotate(3*PI/2);
  fill(255,255,255);
  if(selected == 1){
    fill(255, 255, 0);
    if(count > 0){
       if (count % 4 == 0){
         d12 = dSides[(int)(Math.random()*12)];
       }
    } 
    if(count > 100){
       count = 0; 
       change = false; 
    }
  }
  polygon(0,0,70,10);
  polygon(0,0, 40, 5); 
  popMatrix();
  
  pushMatrix(); 
  translate(width*0.8, d6Height); 
  rotate(PI/4);
  fill(255,255,255);
  if(selected == 2){
    fill(255, 255, 0);
    if(count > 0){
       if (count % 4 == 0){
         d6 = dSides[(int)(Math.random()*6)];
       }
    } 
    if(count > 100){
       count = 0; 
       change = false; 
    }
  }
  polygon(0,0, 65, 4); 
  popMatrix(); 
  
  pushMatrix();
  translate(width*0.2, d20Height);
  fill(0); 
  text(d20, -15, 8); 
  popMatrix(); 
  
  pushMatrix();
  translate(width*0.5, d12Height);
  fill(0); 
  text(d12, -15, 8); 
  popMatrix(); 
  
  pushMatrix();
  translate(width*0.8, d6Height);
  fill(0); 
  text(d6, -10, 8); 
  popMatrix(); 
  
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void instructionText(){
    textSize(24);
    text("Welcome to a dice rolling adventure! ", 150, 60);
    textSize(40); 
    text("It's your turn to roll! ", 130, 160);
    textSize(20);
    text("Use the joystick to indicate the direction of the dice you wish"+ 
       "\nto use, and activate the switch to switch between dice. Push "+
       "\ndown on the joystick to find the instructions (but you've done"+
       "\nthat bit already, haven't you?). Click the yellow button to roll.", 20, 460);
    textSize(24);
    
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
