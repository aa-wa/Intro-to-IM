//initialize the ledPin in which the circuit is connected
const int ledPin = 2;

// the setup routine runs once when you press reset:
void setup() {
  // make the ledPin's pin an output
  pinMode(ledPin, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  //pass current through the ledPin when the circuit is closed
  digitalWrite(ledPin, HIGH);
}
