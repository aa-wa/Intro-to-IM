import processing.serial.*; //importing the serial library

Serial myPort; //define the serial library

void setup() {
  size(500, 500); //size of the window
  myPort = new Serial(this, "COM3", 9600); //giving the information about the Arduino port
}

void draw() {
  background(0); //setting the background
  if (keyPressed && keyCode == UP) { //if given key is pressed,
    myPort.write("1");               // the LED lights up
  } else if (keyPressed && keyCode == DOWN) { // if given key is presssed,
    myPort.write("0");                      // the LED turns off
  }
}
