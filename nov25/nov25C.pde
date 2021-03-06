import processing.serial.*;

Serial myPort;

PVector velocity;
PVector gravity;
PVector position;
PVector acceleration;
PVector wind;
float drag = 0.99;
float mass = 50;
float hDampening;

void setup() {
  size(640, 360);
  noFill();
  position = new PVector(width/2, 0);
  velocity = new PVector(0, 0);
  acceleration = new PVector(0, 0);
  gravity = new PVector(0, 0.5*mass);
  wind = new PVector(0, 0);
  hDampening=map(mass, 15, 80, .98, .96);
  
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
}

void draw() {
  background(255);
  if (!keyPressed) {
    wind.x=0;
    velocity.x*=hDampening;
  }
  applyForce(wind);
  applyForce(gravity);
  velocity.add(acceleration);
  velocity.mult(drag);
  position.add(velocity);
  acceleration.mult(0);
  ellipse(position.x, position.y, mass, mass);
  if (position.y > height-mass/2) {
    velocity.y *= -0.9;  // A little dampening when hitting the bottom
    position.y = height-mass/2;
  }
  if (position.y >= height - mass/2) {
    myPort.write("1");
  } else if (position.y != height - mass/2) {
    myPort.write("0");
  }
}

void applyForce(PVector force) {
  // Newton's 2nd law: F = M * A
  // or A = F / M
  PVector f = PVector.div(force, mass);
  acceleration.add(f);
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  // Always check to make sure the string isn't empty
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to a float
    position.x = float(inString);
    // map to the width of the screen
    position.x = map(position.x, 0, 1023, 0, width);
    println(position.x);
  }
}
