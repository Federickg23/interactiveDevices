#define BUTTON_ONE  18
#define BUTTON_TWO  32
#define SWITCH_PIN 4

int xyzPins[] = {13, 12, 14};   //x,y,z pins

void setup() {
  Serial.begin(115200);
  pinMode(xyzPins[2], INPUT_PULLUP);  //z axis is a button.
  pinMode(BUTTON_ONE, INPUT);
  pinMode(BUTTON_TWO, INPUT); 
  pinMode(SWITCH_PIN, INPUT); 
}
void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  int b1 = digitalRead(BUTTON_ONE); 
  int b2 = digitalRead(BUTTON_TWO); 
  int switchVal = digitalRead(SWITCH_PIN); 
  Serial.printf("%d,%d,%d,%d,%d,%d\n", xVal, yVal, zVal, b1, b2, switchVal);
  delay(1000);
}
