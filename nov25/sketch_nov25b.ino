const int ledPin = 4;    //define the LED pin

void setup() {

  pinMode(ledPin, OUTPUT);    //initialize LED output
  Serial.begin(9600);         //start the serial communication
}

void loop() {

  if (Serial.available() > 0) {         //if some data is available of in the serial port
    char ledPinState = Serial.read();   //read the value
    if (ledPinState == '1') {           //if statement will be true(1)
      digitalWrite(ledPin, HIGH);       //turn ON the LED
      delay(50);
      digitalWrite(ledPin, LOW);
    }
  }
}
