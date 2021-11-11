
// Simple Traffic Light LEDs


//Defining the pins to LEDs, LDR and the Button 
const int ledPin1 = 2; //red led
const int ledPin2 = 3; //yellow led
const int ledPin3 = 4; //green led
const int ldrPin = A0;
const int buttonPin = 8;

int brightness = 0; //brightness manipulator variable for the analog pin
int fadeAmount = 5; //fade manipulator variable for the analog pin


void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPin, INPUT); //assigning the buttonPin as input

  //assigning ledPins as outputs
  pinMode(ledPin1, OUTPUT); 
  pinMode(ledPin2, OUTPUT);
  pinMode(ledPin3, OUTPUT);

  pinMode(ldrPin, INPUT); //assigning ldrPin as input
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly
  int buttonState = digitalRead(buttonPin); //reading button output
  int ldrState = analogRead(ldrPin); //reading ldr output

  //when button is pressed
  if (buttonState == HIGH) { 
    digitalWrite(ledPin1, HIGH); //redLed glows

    //when light to ldr is blocked
    if (ldrState <= 300) {
      digitalWrite(ledPin1, LOW); //red led goes off
      analogWrite(ledPin2, brightness); //yellow led fades in
      brightness = brightness + fadeAmount;
      if (brightness >= 255) {
        fadeAmount = -fadeAmount; //yellow led starts fading out after reaching maximum brightness and goes off
      }
      else if (brightness <= 0) {
        fadeAmount = 0; 
        digitalWrite(ledPin3, HIGH); //green led glows
      }
      delay(50); //delay to see the dimming effect
    }
  }

  //when the button is not pressed
  else if (buttonState == LOW) {
    digitalWrite(ledPin1, LOW); //red led is off
    digitalWrite(ledPin3, LOW); //green led is off
    analogWrite(ledPin2, 0); //yellow led is off
    fadeAmount = 5; //fadeAmount goes back to 5 so that when the button is pressed again, the yellow led fades in
  }
}
