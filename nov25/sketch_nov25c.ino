const int ledPin = 4;    //define the LED pin
const int potPin = A3;  //define the potentiometer pin

void setup() {
  pinMode(potPin, INPUT);      // initialize the Potentiometer input
  pinMode(ledPin, OUTPUT);    //initialize LED output
  Serial.begin(9600);         //start the serial communication
}

void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(potPin);
  // print out the value you read:
  Serial.println(sensorValue);
  delay(1);        // delay in between reads for stability
  if (Serial.available() > 0) {         //if some data is available of in the serial port
    char ledPinState = Serial.read();   //read the value
    if (ledPinState == '1') {           //if statement will be true(1)
      digitalWrite(ledPin, HIGH);       //turn ON the LED
    }
    else if (ledPinState == '0') {
      digitalWrite(ledPin, LOW);
    }
  }
}
