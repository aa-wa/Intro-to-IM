# Tic-Tac-Toe with External Controllers and Speaker and Mini-Monitor

## Concept

My final project will be the modified version of me Mid-Term Project. I want to continue with my Tic-Tac-Toe. However, I want to make it so that the game is controlled through Arduino. 

## Using Arduino

The turning of the potentiometer selects the box in which the 'Tic-Tac' or the 'Toe' is to be placed and pressing the switch places the 'Tic-Tac' or the 'Toe'. And, every time a Tic-Tac is placed, a blue LED glows for some time and every time a Toe is placed, a yellow LED glows for some time. Similarly, in case anyone wins, a Green LED glows, a blue led (if Tic-Tac wins) or a yellow LED (if Toe wins) blinks, and a victory sound effect is played through the Buzzer. In case of a draw, a red LED fades in and out. The LED Screen will show who has won the game.

## Using Processing

The game will be displayed on a processing window, however it will be controlled through Arduino.

## Difficulties

The major problem I see is the way the potentiometer will work. Because there are 9 compartments in the game, the rotation is to be limited to (total revolution in degrees/9) for a single compartment. I don't know if one will be able to stably hold it in the desired compartment because of the size of the angle. Besides this, I haven't used the LED screen before and I may mess it up. Composing a victory sound effect through the buzzer may also be a pain.
