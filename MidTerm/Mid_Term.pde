// This is the classic tic-tac-toe with a twist (tic-tacs for circles and toes for crosses)
import processing.sound.*;

PImage ticTac;
PImage toe;

SoundFile bg;
SoundFile winGame;

Box[][] board; //an array of Boxes called board
int NUMCOLS = 3;
int NUMROWS = 3;
int player = 0; //for variable player, 0 = TicTac, 1 = Toe
int win = 0;  //for variable win, 0 = no one wins, 1 = TicTac wins,  2 = Toe wins;
int game = 0;  // 1 = game started, 0 = game not started
int full = 9; // total 9 boxes in the board, which'll decrease as each box fills
int winSoundPlayer = 1;// to control how many times the win sound effect is played


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
  void click(int tileX, int tileY) {
    int mx = tileX; // mx = mouseX
    int my = tileY; // my = mouseY


    if (mx > xPos && mx < xPos + w && my > yPos && my < yPos + h) {

      if (player == 0 && condition == 0) { //TicTac's turn
        condition = 1; //box fills with TicTac
        full -= 1; //one box on the board decreases
        player = 1; //turn changes to Toe
      } else if (player == 1 && condition == 0) {
        condition = 2; //box fills with Toe
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
      if ( win == 1) {
        text("TIC-TAC \n WINS!", board[i][j].checkX()+40, board[i][j].checkY()+50);
      } else if ( win == 2) {
        text("TOE \n WINS!", board[i][j].checkX()+50, board[i][j].checkY()+50);
      }
    }
  }


  if (win == 1 || win == 2) { //for either tictac or toe win
    fill(0, 0, 255);
    textSize(20);
    bg.stop();
    text("ENTER to Start Again", 10, height-10);
  }

  if (win == 0 && full == 0) {  // for a draw .i.e. if the win state is 0 and the board fills
    fill(0, 0, 255);
    textSize(20);
    bg.stop();
    text("ENTER to Start Again", 10, height-10);
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
  bg = new SoundFile(this, "bgm.wav"); //initializing background sound
  winGame = new SoundFile(this, "win.mp3"); //initializing win sound effect
}

void draw() {
  background(0);
  // intro-page
  if (game == 0) {
    fill(255);
    textSize(width/20);
    text("Press ENTER to Start\n Click to Fill in Tic-Tac or Toe", width/2-width/4, height/2);
  }

  //game start
  if (game == 1) {
    checkGame();  // checking if a player has won
    for (int i = 0; i<NUMCOLS; i++) {
      for (int j = 0; j<NUMROWS; j++) {
        board[i][j].display();
      }
    }
    if (win ==0) { // if it is game phase and no one is winning, the winSoundPlayer variable is set to 1
      winSoundPlayer = 1;
    }
    if ((win ==1 || win == 2) && (winSoundPlayer ==1)) { // if someone wins and the winSoundPlayer variable is euqal to one, the win sound effect is played once and the value of the variable increases every frame so that the sound effect doesn't repeat
      winGame.play();
      winSoundPlayer += 1;
    }
  }
}

//mouse & key functions
void mousePressed() {
  if (game == 1) {
    if (win == 0) {
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].click(mouseX, mouseY); //filling the box wherever the mouse is clicked
        }
      }
    }
  }
}

void keyPressed() {
  if (game == 0) {
    if (key == ENTER) {
      game = 1; //game-phase
      bg.play();
      full = 9;
    }
  } else if (game == 1 && win == 0 && full == 0 ) {
    if (key == ENTER) {
      game = 0; // start game again if drawn
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].clearBoard(); //clear the board before starting the game
          win = 0;
          full = 9;
        }
      }
    }
  } else if ( game == 1 && (win == 1 || win ==2)) {
    if (key == ENTER) {
      game = 0; // start game again if either tictac or toe wins
      for (int i = 0; i<NUMCOLS; i++) {
        for (int j = 0; j<NUMROWS; j++) {
          board[i][j].clearBoard();
          win = 0;
          full = 9;
        }
      }
    }
  }
}
