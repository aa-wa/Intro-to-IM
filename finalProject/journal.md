# Tic-Tac-Toe with External Controllers and Speaker and Mini-Monitor

## Concept

My final project will be the modified version of me Mid-Term Project. I want to continue with my Tic-Tac-Toe. However, I want to make it so that the game is controlled through Arduino. 

## Using Arduino

The turning of the potentiometer selects the box in which the 'Tic-Tac' or the 'Toe' is to be placed and pressing the switch places the 'Tic-Tac' or the 'Toe'. And, every time a Tic-Tac is placed, a blue LED glows for some time and every time a Toe is placed, a yellow LED glows for some time. Similarly, in case anyone wins, a Green LED glows, a blue led (if Tic-Tac wins) or a yellow LED (if Toe wins) blinks, and a victory sound effect is played through the Buzzer. In case of a draw, a red LED fades in and out. The LED Screen will show who has won the game.

## Using Processing

The game will be displayed on a processing window, however it will be controlled through Arduino.

## Difficulties

The major problem I see is the way the potentiometer will work. Because there are 9 compartments in the game, the rotation is to be limited to (total revolution in degrees/9) for a single compartment. I don't know if one will be able to stably hold it in the desired compartment because of the size of the angle. Besides this, I haven't used the LED screen before and I may mess it up. Composing a victory sound effect through the buzzer may also be a pain.

## Progress Report I

### Status

Creating the game itself was not a issue as I had done it for my Mid-Term previously. I burrowed coe from my own past Processing file to build the game. The project is more or less complete as I've dealt with the isssue that was seemed to be the most difficult at first for me as well - I've implemented the potentiometer and the switch into the game. Although the screen, the buzzer and the LEDs remain, I've watched enough videos and references and done ecnough work in class with them to make them work promptly. 

### The Potentiometer Issue

In my project, the potentiometer was meant to select the box in which the players place their signs. First, I created a selector box for this that hovers over the boxes of the board. Then, I assigned values to the boxes ranging from 1 to 9 such that when the integer val equals 1, the selector hovers over the first box, for 2, it hovers over the second box and so on. Getting this concept right was the most time consuming thing throughout the implementation of the potentiometer in the game. After this, I simply mapped the potentiometer values to the values of the boxes. 

### Getting the Switch effect

The switch puts the desired symbol into the box over which the selector box is hovering. I made it so that whenever the computer read 'HIGH' from the button pin of the Arduino, the game put a 'Tic-Tac' or a 'Toe' in the box over which the selector is hovering.

### Link to the Test 

https://drive.google.com/drive/folders/1YndsPrWcwF0Oq18grMoxbd-DeOwDQfEG?usp=sharing
