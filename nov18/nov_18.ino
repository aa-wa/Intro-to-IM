//national anthem player and flag waver

#include <Servo.h> //for the servo motor
#include "pitches.h" // for the notes

// defining different constant variables for different pins
const int spkrPin = 7;
const int buttonPin = 8;
const int servoPin = 2;
const int ldrPin = A0;

// initializing the servo motor object
Servo myservo;

// notes in the melody:
int melody[] = {
  NOTE_CS4, NOTE_B3, NOTE_A3, NOTE_B3, NOTE_A3, NOTE_FS3, NOTE_A3, NOTE_FS3, NOTE_E3, NOTE_FS3, NOTE_FS3, NOTE_CS4, NOTE_CS4, NOTE_B3, NOTE_FS3, NOTE_A3
};

// note durations: 4 = quarter note, 2 = half note, etc.:
int noteDurations[] = {
  4, 4, 4, 4, 4, 4, 4, 4, 4, 2, 4, 2, 4, 1, 2, 1
};

void setup() {
  pinMode(buttonPin, INPUT); //assigning the buttonPin as input
  pinMode(ldrPin, INPUT); //assigning ldrPin as input
  myservo.attach(servoPin); //attaching the servo motor object to the pin attached to the actual servo motor
  Serial.begin(9600); 
}

void loop() {
  int buttonState = digitalRead(buttonPin); //reading button output
  int ldrState = analogRead(ldrPin); //reading ldr output

  if (buttonState == HIGH) { //if the button is pressed, the instrument starts to operate 

    if (ldrState <= 300) { // if less light passes through the ldr sensor, the national anthem melody will play
      // iterate over the notes of the melody:
      for (int thisNote = 0; thisNote < 16; thisNote++) {

        // to calculate the note duration, take one second divided by the note type.
        //e.g. quarter note = 1000 / 4, eighth note = 1000/8, etc.
        int noteDuration = 1000 / noteDurations[thisNote];
        tone(spkrPin, melody[thisNote], noteDuration);

        // to distinguish the notes, set a minimum time between them.
        // the note's duration + 30% seems to work well:
        int pauseBetweenNotes = noteDuration * 1.30;
        delay(pauseBetweenNotes);
      }
    }
    else { //if more light passes through the ldr sensor, the servo motor will wave the flag attached to it
      myservo.write(130);
      delay(400);
      myservo.write(140);
      delay(400);
    }

  }
}
