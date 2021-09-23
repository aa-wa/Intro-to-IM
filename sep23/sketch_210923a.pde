//a system that loses energy (and the starts gaining energy infinitely)

// naming variables for the block and giving them appropriate values
int BLOCKHEIGHT = 30;
int BLOCKWIDTH = 30;
int SPEED = 30;
int ENERGY = 3; // the is the kinetic energy which the blocks will lose after each collision, and later gain

// creating the class for the blocks falling vertically
class FallingBlock {
  float x, y, v, h, e, w;

  FallingBlock(float xPos, float yPos) {
    // the constructors
    x = xPos;
    y = yPos;
    v = SPEED;
    h = BLOCKHEIGHT;
    w = BLOCKWIDTH;
    e = ENERGY;
  }

// giving the block velocity
  void update() {
    y += v;
  }

// checking collisions and decreasing the energy of the blocks after each collision
  void checkCollision() {
    if ((y<=0) || (y+w >= height)) {
      e = -e;
      v = -v - e;
    }
  }
  
// drawing the blocks in a row 
  void drawBlocks() {
    fill(255);
    for (x = 30; x+w < width; x=x+70) {
      rect(x, y, h, w);
    }
  }
}

// class for the blocks moving horizontally
class MovingBlock{
  float x, y, v, h, e, w;
  
  MovingBlock(float xPos1, float yPos1) {
    x = xPos1;
    y = yPos1;
    v = SPEED;
    h = BLOCKHEIGHT;
    w = BLOCKWIDTH;
    e = ENERGY;
  }
  void update() {
    x += v;
  }

// checking collisions and decreasing the energy of the blocks after each collision
  void checkCollision() {
    if ((x<=0) || (x+w >= width)) {
      e = -e;
      v = -v - e;
    }
  }
  
// drawing the blocks in a row 
  void drawBlocks() {
    fill(255);
    for (y = 30; y+h < height; y=y+70) {
      rect(x, y, h, w);
    }
  }
}
    
  

// initializing the FallingBlock and MovingBlock classes
FallingBlock MyBlock = new FallingBlock(0,0);
MovingBlock MyBlock1 = new MovingBlock(0,35);

void setup() {
  size(700, 700);
  smooth();
}

void draw() {
  background(0);
  MyBlock.update();
  MyBlock.checkCollision();
  MyBlock.drawBlocks();
  MyBlock1.update();
  MyBlock1.checkCollision();
  MyBlock1.drawBlocks();
}
