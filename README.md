MIPS-Wizards Of Wor


## How To Run

1. Open the Mars .jar file from our repo.
2. Load the wow.asm file into Mars with File -> Open.
3. Go to Run -> Assemble
4. Go to tools -> Bitmap Display
5. The Bitmap Display settings should be as follows:
  - Unit Width: 8
  - Unit Height: 8
  - Display Width: 512
  - Display Height: 512
  - Base Address: $gp
6. Go to tools -> Keyboard and Display MMIO Simulator
7. Press connect to MIPS on both of the displays
8. Go to Run -> Go
9. All controls should take place in the lower portion of the Keyboard and Display Simulator

## Controls

Press space to start game

move the player with:  ASWD

shoot with: IJKL

## Game Dinamic

There are three levels in which you should kill the two enemies that move, but be carefull there may be invisible obstacles depending on the level. These invisible obstacles could make you loose a life and you only have three. 

The blue dots on the left indicate your current level, the orange dots in the middle indicate the killed enemies of the current level and the red dots on the right indicate the lives that you have lost (you only have three)
