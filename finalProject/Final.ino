#include "pitches.h"

// defining pins for the inputs
const int potPin = A3;
const int buttonPin = 2;

// defining pins for the outputs
const int blueLedPin = 4;
const int greenLedPin = 5;
const int redLedPin = 6;
const int yellowLedPin = 7;
const int spkrPin = 8;

// defining notes from pitches.h
int melody[] = {
  NOTE_B3, NOTE_D2
};

// note durations: 4 = quarter note, 2 = half note, etc.:
int noteDurations[] = {
  4
};

// defining some integers for delaying sound/light and fading
int ledDelay, noteDelay = millis();
int fadeValue, thisNote = 0;

// initial pin state for all the LEDs
char ledPinState = '0';

void setup() {
  // initializing the inputs
  pinMode(buttonPin, INPUT);
  pinMode(potPin, INPUT);

  // initializing the outputs
  pinMode(blueLedPin, OUTPUT);
  pinMode(yellowLedPin, OUTPUT);
  pinMode(greenLedPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);

  Serial.begin(9600); // initialize serial communication at 9600 bits per second:
}


void loop() {
  int sensorValue = analogRead(potPin); // assigning potentiometer value to an integer
  Serial.println(sensorValue); // print out the value you read
  delay(1);        // delay in between reads for stability

  int buttonState = digitalRead(buttonPin); // reading if the button is pressed

  if (buttonState == HIGH) {  // If switch is ON,
    Serial.println("HIGH");   // send "HIGH" to Processing
  } else {
    Serial.println("LOW");      // If the switch is not ON, send "LOW" to Processing
  }
  
  // read the input on analog pin 0:
  if (Serial.available() > 0) {         //if some data is available of in the serial port
    ledPinState = Serial.read();        //read the value
  }

  if (ledPinState == '0') { // For when the game isn't started
    noTone(spkrPin); // the buzzer doesn't play

    // all the LEDs are off
    analogWrite(greenLedPin, 0);
    analogWrite(redLedPin, 0);
    digitalWrite(blueLedPin, LOW);
    digitalWrite(yellowLedPin, LOW);
  }

  else if (ledPinState == '1') { 
    digitalWrite(blueLedPin, HIGH);
    digitalWrite(yellowLedPin, LOW);
  }

  else if (ledPinState == '2') {
    digitalWrite(yellowLedPin, HIGH);
    digitalWrite(blueLedPin, LOW);
  }

  else if (ledPinState == '3') {
    digitalWrite(yellowLedPin, LOW);
    digitalWrite(blueLedPin, LOW);

    analogWrite(greenLedPin, fadeValue);
    if (millis() - ledDelay > 5) {
      fadeValue = (fadeValue + 5) % 255;
      ledDelay = millis();
    }
    // to calculate the note duration, take one second divided by the note type.
    //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
    int noteDuration = 1000 / noteDurations[thisNote];
    tone(spkrPin, melody[thisNote], noteDuration);
  }

  else if (ledPinState == '4') {
    digitalWrite(yellowLedPin, LOW);
    digitalWrite(blueLedPin, LOW);

    analogWrite(redLedPin, fadeValue);
    if (millis() - ledDelay > 5) {
      fadeValue = (fadeValue + 5) % 255;
      ledDelay = millis();
    }
    int noteDuration = 1000 / noteDurations[thisNote + 1];
    tone(spkrPin, melody[thisNote + 1], noteDuration);

  }
}
