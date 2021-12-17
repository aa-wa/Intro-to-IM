import processing.serial.*;
Serial myPort;        // The serial port

PImage ticTac;
PImage toe;

Box[][] board; //an array of Boxes called board
int NUMCOLS = 3;
int NUMROWS = 3;
int player = 0; //for variable player, 0 = TicTac, 1 = Toe
int win = 0;  //for variable win, 0 = no one wins, 1 = TicTac wins,  2 = Toe wins;
int game = 0;  // 1 = game started, 0 = game not started
int full = 9; // total 9 boxes in the board, which'll decrease as each box fills
float selX = 0;
float selY = 0;
float val;

//BOX CLASS
class Box {
  int xPos;
  int yPos;
  int w; //width
  int h; //height
  int condition = 0; //condition accounts for if the box is filled or not; 0 = not filled, 1 = filled with TicTac, 2 = filled with Toe

  Box(int tileX, int tileY, int tileW, int tileH) {
    xPos = tileX;
    yPos = tileY;
    w = tileW;
    h = tileH;
  }

  //defining what happens after a click of the mouse
  void click(float tileX, float tileY) {
    float sx = tileX; // sx = selector X
    float sy = tileY; // sy = selector Y


    if (sx > xPos && sx < xPos + w && sy > yPos && sy < yPos + h) {

      if (player == 0 && condition == 0) { //TicTac's turn
        condition = 1; //box fills with TicTac
        myPort.write("1");
        full -= 1; //one box on the board decreases
        player = 1; //turn changes to Toe
      } else if (player == 1 && condition == 0) {
        condition = 2; //box fills with Toe
        myPort.write("2");
        full -= 1; //one box on the board decreases
        player = 0; //turn changes to TicTac
      }
    }
  }

  void clearBoard() { //function to clear the board before restarting the game
    condition = 0;
  }

  int checkCondition() { //integer to check the condition of a box
    return condition;
  }

  int checkX() { //integer to check the xPosition of the box
    return xPos;
  }

  int checkY() { //integer to check the yPosition of the box
    return yPos;
  }

  void display() { //displaying the box
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(xPos, yPos, w, h);
    if (condition == 1) {
      ticTac = loadImage("TicTac.png"); //if the condition is 1, the box fills with the image of a tictac
      if (ticTac == null) {
        exit();
      }
      ticTac.resize(w, 0);
      image(ticTac, xPos, yPos);
    } else if (condition == 2) {
      toe = loadImage("Toe.png"); //if the condition is 2, the box fills with the image of a toe
      if (toe == null) {
        exit();
      }
      toe.resize(w, 0);
      image(toe, xPos, yPos);
    }
  }
}

void selector() {
  stroke(123, 20, 23);
  strokeWeight(4);
  rect(selX, selY, width/3, height/3);
  if (val >= 0 && val <= 1) {
    selX = 0;
    selY = 0;
  } else if (1 < val && val <= 2) {
    selX = width/3 ;
    selY = 0;
  } else if (2 < val && val <= 3) {
    selX = 2*width/3;
    selY =0;
  } else if (3 < val && val <= 4) {
    selX = 0;
    selY = height/3;
  } else if (4 < val && val <= 5) {
    selX = width/3;
    selY =height/3;
  } else if (5 < val && val <= 6) {
    selX = 2*width/3;
    selY = height/3;
  } else if (6 < val && val <= 7) {
    selX = 0;
    selY = 2*height/3;
  } else if (7 < val && val <= 8) {
    selX = width/3;
    selY = 2*height/3;
  } else if (8 < val && val <= 9) {
    selX = 2*width/3;
    selY = 2*height/3;
  }
}

void checkGame() { //checking who wins
  int row = 0;
  //check vertical & horizontal
  for (int col = 0; col< NUMCOLS; col++) {
    if (board[col][row].checkCondition() == 1 && board[col][row+1].checkCondition() == 1 && board[col][row+2].checkCondition() == 1) { //for vertical tictac win
      win = 1;
    } else if (board[row][col].checkCondition() == 1 && board[row+1][col].checkCondition() == 1 && board[row+2][col].checkCondition() == 1) { //for horizontal tictac win
      win = 1;
    } else if (board[row][col].checkCondition() == 2 && board[row+1][col].checkCondition() == 2 && board[row+2][col].checkCondition() == 2) { //for vertical toe win
      win = 2;
    } else if (board[col][row].checkCondition() == 2 && board[col][row+1].checkCondition() == 2 && board[col][row+2].checkCondition() == 2) { //for vertical toe win
      win = 2;
    }
  }

  //check diagonals
  if (board[row][row].checkCondition() == 1 && board[row+1][row+1].checkCondition() == 1 && board[row+2][row+2].checkCondition() == 1) { //top left to bottom right diagonal tictac win
    win = 1;
  } else if (board[row][row].checkCondition() == 2 && board[row+1][row+1].checkCondition() == 2 && board[row+2][row+2].checkCondition() == 2) {//top left to bottom right diagonal toe win
    win = 2;
  } else if (board[0][row+2].checkCondition() == 1 && board[1][row+1].checkCondition() == 1 && board[2][row].checkCondition() == 1) {//top right to bottom left diagonal tictac win
    win = 1;
  } else if (board[0][row+2].checkCondition() == 2 && board[1][row+1].checkCondition() == 2 && board[2][row].checkCondition() == 2) {//top right to bottom left diagonal toe win
    win = 2;
  }


  //write text
  fill(255);
  textSize(20);
  for (int i = 0; i<NUMCOLS; i++) {
    for (int j = 0; j<NUMROWS; j++) {
      if (win == 1) {
        text("TIC-TAC \n WINS!", board[i][j].checkX()+40, board[i][j].checkY()+50);
      } else if (win == 2) {
        text("TOE \n WINS!", board[i][j].checkX()+50, board[i][j].checkY()+50);
      }
    }
  }



  if (win == 1 || win == 2) { //for tictac win
    fill(0, 0, 255);
    textSize(20);
    text("ENTER to Start Again", 10, height-10);
    myPort.write("3");
  }

  if (win == 0 && full == 0) {  // for a draw .i.e. if the win state is 0 and the board fills
    fill(0, 0, 255);
    textSize(20);
    text("ENTER to Start Again", 10, height-10);
    myPort.write("4");
  }
}


void setup() {
  size(600, 600);
  smooth();
  board = new Box[NUMCOLS][NUMROWS]; //initializing the board array
  for (int i = 0; i< NUMCOLS; i++) {
    for ( int j = 0; j < NUMROWS; j++) {
      board[i][j] = new Box(width/3*i, height/3*j, width/3, height/3); //filling the board array with boxes
    }
  }
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n'); // don't generate a serialEvent() unless you get a newline character:
}

void draw() {
  background(0);
  // intro-page
  if (game == 0) {
    myPort.write("5");
    fill(255);
    textSize(width/20);
    text("Press ENTER to Start\n\n Turn potentiometer to select Box\n Click button to fill in \n Yellow = Tic-Tac        Blue = Toe", width/2-width/3, height/3);
  }

  //game start
  if (game == 1) {
    checkGame();  // checking if a player has won
    for (int i = 0; i<NUMCOLS; i++) {
      for (int j = 0; j<NUMROWS; j++) {
        board[i][j].display();
      }
    }
    selector();
  }
}

void keyPressed() {
  if (game == 0) {
    if (key == ENTER) {
      myPort.write("2");
      game = 1; //game-phase
      //bg.play();
      full = 9;
    }
  } else if (game == 1 && win == 0 && full == 0 ) {
    if (key == ENTER) {
      game = 0; // start game again if drawn
      myPort.write("0");
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].clearBoard(); //clear the board before starting the game
          win = 0;
          full = 9;
          player = 0;
        }
      }
    }
  } else if (game == 1 && (win == 1 || win ==2)) {
    if (key == ENTER) {
      game = 0; // start game again if either tictac or toe wins
      myPort.write("0");
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].clearBoard();
          win = 0;
          full = 9;
          player = 0;
        }
      }
    }
  }
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');

  // Always check to make sure the string isn't empty
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    println(inString);
    if (inString.equals("HIGH")) {
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].click(selX+1, selY+1); //filling the box wherever the button is clicked
        }
      }
    } else {
      // convert to a float
      float inByte = float(inString);
      val = map(inByte, 0, 1023, 0, 9);
    }
  }
}
