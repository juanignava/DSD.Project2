.data
	killedEnemies:		.word 0
	Level:			.word 4 # 0 for main window
					# 1, 2 and 3 for the repective level
	Lives:			.word 0
	bulletColor:		.word 0x00ffff00 # Yellow
	playerColor:		.word 0x0000ff00 # Green
	enemyColor:		.word 0x00ff0000 # Red
	backgroundColor:	.word 0x00000000 # Black
	wallColor:		.word 0x00ffffff # White
	radarColor:		.word 0x0000ffbf # LightGreen
	radarObjColor:		.word 0x00ffa200 # Orange
	bulletDir:		.word 1
					# 0 -> up
					# 1 -> right
					# 2 -> down
					# 3 -> left
	bulletActive:		.word 0
					# 0 -> bullet inactive
					# 1 -> bullet active
	
	
.text

NewGame:
	jal ClearBoard
	
	WOW: # The inicial screen text
	
		# Letter W
		li $a0, 3
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
		li $a0, 4
		li $a1, 26
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 5
		li $a1, 25
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 6
		li $a1, 24
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 7
		li $a1, 23
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 8
		li $a1, 22
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 9
		li $a1, 21
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 10
		li $a1, 20
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 11
		li $a1, 19
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 12
		li $a1, 20
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 13
		li $a1, 21
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 14
		li $a1, 22
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 15
		li $a1, 23
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 16
		li $a1, 24
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 17
		li $a1, 25
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 18
		li $a1, 26
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 19
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
		# Letter O
		
		li $a0, 24
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
		li $a0, 24
		li $a1, 26
		lw $a2, wallColor
		li $a3, 40
		jal DrawHorizontalLine
		
		li $a0, 24
		li $a1, 6
		lw $a2, wallColor
		li $a3, 40
		jal DrawHorizontalLine
		
		li $a0, 40
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
		# Letter W
	
		li $a0, 45
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
		li $a0, 46
		li $a1, 26
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 47
		li $a1, 25
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 48
		li $a1, 24
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 49
		li $a1, 23
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 50
		li $a1, 22
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 51
		li $a1, 21
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 52
		li $a1, 20
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 53
		li $a1, 19
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 54
		li $a1, 20
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 55
		li $a1, 21
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 56
		li $a1, 22
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 57
		li $a1, 23
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 58
		li $a1, 24
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 59
		li $a1, 25
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 60
		li $a1, 26
		lw $a2, wallColor
		jal DrawPoint
		
		li $a0, 61
		li $a1, 6
		lw $a2, wallColor
		li $a3, 26
		jal DrawVerticalLine
		
			
SelectMode:
	lw $t1, 0xFFFF0004		# check to see which key has been pressed
	beq $t1, 0x00000020, BeginGame 	# SPACE pressed
		
	li $a0, 250	#
	li $v0, 32	# pause for 250 milisec
	syscall		#
		
	j SelectMode    # Jump back to the top of the wait loop
	

BeginGame:
	sw $zero, 0xFFFF0000	# clear the button pushed bit
	li $t1, 1
	sw $t1, Level
	sw $zero, killedEnemies	
	
# $s0 stores player X position
# $s1 stores player Y position
# $s2 stores enemy 1 X position
# $s3 stores enemy 1 Y position
# $s4 stores enemy 2 X position
# $s5 stores enemy 2 Y position
# $s6 stores bullet X position
# $s7 stores bullet Y position
NewRound:

	# Initialize all the registers for a new level
	li $t0, 1
	sw $t0, bulletDir
	
	li $s0, 23	#Player initial coordinates
	li $s1, 6
	
	li $s2, 24	# Enemy 1 initial coordinates
	li $s3, 15
	
	li $s4, 33	# Enemy 2 initial coordinates
	li $s5, 12
	
	li $s6, -2	# Bullet initial coordinates
	li $s7, -2

	jal ClearBoard
	
	# Draw Level
	lw $a2, Level
	li $a3, 3
	lw $a1, radarColor
	jal DrawDots
	
	# Draw Killed Enemies
	lw $a2, killedEnemies
	li $a3, 34
	lw $a1, radarObjColor
	jal DrawDots
	
	# Draw Lives
	lw $a2, Lives
	li $a3, 40
	lw $a1, enemyColor
	jal DrawDots
	
	# Draw Board
	li $a0, 22
	li $a1, 5
	lw $a2, wallColor
	li $a3, 17
	jal DrawVerticalLine
	
	li $a0, 42
	li $a1, 5
	lw $a2, wallColor
	li $a3, 17
	jal DrawVerticalLine
	
	li $a0, 22
	li $a1, 5
	lw $a2, wallColor
	li $a3, 42
	jal DrawHorizontalLine
	
	li $a0, 22
	li $a1, 17
	lw $a2, wallColor
	li $a3, 42
	jal DrawHorizontalLine
	
	li $a0, 27
	li $a1, 9
	lw $a2, wallColor
	li $a3, 17
	jal DrawVerticalLine
	
	li $a0, 31
	li $a1, 5
	lw $a2, wallColor
	li $a3, 11
	jal DrawVerticalLine
	
	li $a0, 34
	li $a1, 13
	lw $a2, wallColor
	li $a3, 42
	jal DrawHorizontalLine
	
	# Draw player (initial)
	move $a0, $s0
	move $a1, $s1
	lw $a2, playerColor
	jal DrawPoint
	
	# Draw enemies (initial)
	move $a0, $s2
	move $a1, $s3
	lw $a2, enemyColor
	jal DrawPoint
	
	move $a0, $s4
	move $a1, $s5
	lw $a2, enemyColor
	jal DrawPoint
	
	# Draw radar 
	li $a0, 22
	li $a1, 19
	lw $a2, radarColor
	li $a3, 31
	jal DrawVerticalLine
	
	li $a0, 42
	li $a1, 19
	lw $a2, radarColor
	li $a3, 31
	jal DrawVerticalLine
	
	li $a0, 22
	li $a1, 19
	lw $a2, radarColor
	li $a3, 42
	jal DrawHorizontalLine
	
	li $a0, 22
	li $a1, 31
	lw $a2, radarColor
	li $a3, 42
	jal DrawHorizontalLine
	
	
	# Draw player in radar (initial)
	move $a0, $s0
	move $a1, $s1
	addi $a1, $a1, 14
	lw $a2, radarObjColor
	jal DrawPoint
	
	# Draw enemies in radar (initial)
	move $a0, $s2
	move $a1, $s3
	addi $a1, $a1, 14
	lw $a2, radarObjColor
	jal DrawPoint
	
	move $a0, $s4
	move $a1, $s5
	addi $a1, $a1, 14
	lw $a2, radarObjColor
	jal DrawPoint
	
DrawObjects:
	# Check for collisions
	jal PlayerEnemyCollision
	
	# Draw Killed Enemies
	lw $a2, killedEnemies
	li $a3, 25
	lw $a1, radarObjColor
	jal DrawDots
	
	# Draw Lives
	lw $a2, Lives
	li $a3, 40
	lw $a1, enemyColor
	jal DrawDots
	
	# Draw bullet
	lw $t0, bulletActive
	beq $t0, $zero, NoBullet # dont draw if bullet is not active
	
	# Move bullet
	jal MoveBullet
	
	beq $v0, $zero, NoBullet
	move $a0, $s6
	move $a1, $s7
	lw $a2, bulletColor
	jal DrawPoint
	
	
	
	
	
NoBullet:

	# Redraw player
	move $a0, $s0
	move $a1, $s1
	lw $a2, playerColor
	jal DrawPoint

	# Redraw player in radar
	move $a0, $s0
	move $a1, $s1
	addi $a1, $a1, 14
	lw $a2, radarObjColor
	jal DrawPoint
	

	
StartAi:
	# Logic of enemies movements

endAi:
	# Redraw enemies
	# Redraw enemies in radar
	
# Wait and read buttons
Begin_standby:
	li $t0, 0x00000002	# Load 25 into the counter for a aprox 50 milisec stadnby
	
Standby:
	blez $t0, EndStandby
	li $a0, 10	#
	li $v0, 32	# pause for 10 milisec
	syscall		#
	
	addi $t0, $t0, -1 		# decrement counter
		
	lw $t1, 0xFFFF0000		# check to see if a key has been pressed
	blez $t1, Standby
	
	jal AdjustPos	# See what was pushed by the user and adjust position
	sw $zero, 0xFFFF0000
	j Standby
	
EndStandby:
	j DrawObjects
	
	
MoveBullet:
	addi $sp, $sp, -4
   	sw $ra, 0($sp)
   	
	addi $a0, $s6, 0 # Draw over the last point
	addi $a1, $s7, 0
	lw $a2, backgroundColor
	jal DrawPoint
	
	lw $t0, bulletDir
	addi $t1, $zero, 0
	beq $t0, $t1, MoveBulletUp
	addi $t1, $zero, 1
	#beq $t0, $t1, MoveBulletRight
	addi $t1, $zero, 2
	#beq $t0, $t1, MoveBulletDown
	addi $t1, $zero, 3
	#beq $t0, $t1, MoveBulletLeft
	
MoveBulletUp:
	addi $t0, $s7, -1
	addi $a2, $t0, 0
	addi $a1, $s6, 0
	jal CheckNextPos
	beq $v0, 0, DontMoveBullet
	addi $s7, $s7, -1
	
	lw $ra, 0($sp)		# put return back
   	addi $sp, $sp, 4
   	li $v0, 1
	
	jr $ra
#	j BulletCollision
	
DontMoveBullet:
	sw $zero, bulletActive

	
	lw $ra, 0($sp)		# put return back
   	addi $sp, $sp, 4
   	li $v0, 0
	
	jr $ra
	
	
	

# $a2 contains the level number
# $a3 contains the column of the leftmost level dot
# $a1 color
DrawDots: #Used for levels and killed enemies

		addi $sp, $sp, -12	# Stores regiester values to the stack
   		sw $ra, 0($sp)
   		sw $s2, 4($sp)
   		sw $a2, 8($sp)
   		
   		move $s2, $a2
   		addi $a2, $a1, 0
   		
	DrawDotsRow1:			# Draws any score values along the first row
		beq $s2, $zero, DrawDotsEnd
		sub $t1, $s2, 1
		sll $t1, $t1, 1
   		add $a0, $t1, $a3
   		li $a1, 3
   		jal DrawPoint
   		
   		addi $s2, $s2, -1
   		
   		j DrawDotsRow1
	
	DrawDotsEnd:
		lw $ra, 0($sp)		# restores register values from the stack
		lw $s2, 4($sp)
		lw $a2, 8($sp)
   		addi $sp, $sp, 12
		
		jr $ra



# $a0 contains x position, $a1 contains y position, $a2 contains the color	
DrawPoint:
		sll $t0, $a1, 6   # multiply y-coordinate by 64 (length of the field)
		addu $v0, $a0, $t0
		sll $v0, $v0, 2
		addu $v0, $v0, $gp
		sw $a2, ($v0)		# draw the color to the location
		
		jr $ra

# $a0 the x starting coordinate
# $a1 the y coordinate
# $a2 the color
# $a3 the x ending coordinate
DrawHorizontalLine:
		
		addi $sp, $sp, -4
   		sw $ra, 0($sp)
		
		sub $t9, $a3, $a0
		move $t1, $a0
		
	HorizontalLoop:
		
		add $a0, $t1, $t9
		jal DrawPoint
		addi $t9, $t9, -1
		
		bge $t9, 0, HorizontalLoop
		
		lw $ra, 0($sp)		# put return back
   		addi $sp, $sp, 4

		jr $ra

# $a0 the x coordinate
# $a1 the y starting coordinate
# $a2 the color
# $a3 the y ending coordinate
DrawVerticalLine:

		addi $sp, $sp, -4
   		sw $ra, 0($sp)
		
		sub $t9, $a3, $a1
		move $t1, $a1
		
	VerticalLoop:
		
		add $a1, $t1, $t9
		jal DrawPoint
		addi $t9, $t9, -1
		
		bge $t9, 0, VerticalLoop
		
		lw $ra, 0($sp)		# put return back
   		addi $sp, $sp, 4
   		
		jr $ra

# Adjust position, chages the player's position depending on the key pressed
AdjustPos:
	addi $sp, $sp, -4
   	sw $ra, 0($sp)
   	
   	addi $a0, $s0, 0 # Draw over the last point
	addi $a1, $s1, 0
	lw $a2, backgroundColor
	jal DrawPoint
	addi $a1, $s1, 14 # Draw over the last point (RADAR)
	jal DrawPoint
   	
	lw $a0, 0xFFFF0004	# Load button pressed
	
AdjustPos_up:
	bne $a0, 119, AdjustPos_right # Letter w
	addi $t0, $s1, -1
	addi $a2, $t0, 0
	addi $a1, $s0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	
	addi $s1, $s1, -1
	j Adjust_done
	
AdjustPos_right:
	bne $a0, 100, AdjustPos_down # Letter d
	addi $t0, $s0, 1
	addi $a2, $s1, 0
	addi $a1, $t0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s0, $s0, 1
	j Adjust_done
	
AdjustPos_down:
	bne $a0, 115, AdjustPos_left # Letter s
	addi $t0, $s1, 1
	addi $a2, $t0, 0
	addi $a1, $s0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s1, $s1, 1
	j Adjust_done
	
AdjustPos_left:
	bne $a0, 97, BulletCase_up # Letter a
	addi $t0, $s0, -1
	addi $a2, $s1, 0
	addi $a1, $t0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s0, $s0, -1
	j Adjust_done

BulletCase_up:
	bne $a0, 105, BulletCase_right # Letter i
	lw $t0, bulletActive
	bne $t0, $zero, Adjust_done
	addi $t0, $s1, -1
	addi $a2, $t0, 0
	addi $a1, $s0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s6, $s0, 0
	addi $s7, $s1, -1
	li $t0, 0
	sw $t0, bulletDir
	li $t1, 1
	sw $t1, bulletActive
	j Adjust_done
	
	
 BulletCase_right:
 	bne $a0, 108, BulletCase_down # Letter l
 	lw $t0, bulletActive
	bne $t0, $zero, Adjust_done
 	addi $t0, $s0, 1
	addi $a2, $s1, 0
	addi $a1, $t0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s6, $s0, 1
	addi $s7, $s1, 0
	li $t0, 1
	sw $t0, bulletDir
	sw $t0, bulletActive
	j Adjust_done
 	
 BulletCase_down:
 	bne $a0, 107, BulletCase_left # Letter k
 	lw $t0, bulletActive
	bne $t0, $zero, Adjust_done
 	addi $t0, $s1, 1
	addi $a2, $t0, 0
	addi $a1, $s0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s6, $s0, 0
	addi $s7, $s1, 1
	li $t0, 2
	sw $t0, bulletDir
	li $t1, 1
	sw $t1, bulletActive
	j Adjust_done
 	
 BulletCase_left:
 	bne $a0, 106, Adjust_done # Letter j
 	lw $t0, bulletActive
	bne $t0, $zero, Adjust_done
 	addi $t0, $s0, -1
	addi $a2, $s1, 0
	addi $a1, $t0, 0
	jal CheckNextPos
	beq $v0, 0, Adjust_done
	addi $s6, $s0, -1
	addi $s7, $s1,0
	li $t0, 3
	sw $t0, bulletDir
	li $t1, 1
	sw $t1, bulletActive
	j Adjust_done
	
 	
			
Adjust_done:
	lw $ra, 0($sp)		# put return back
   	addi $sp, $sp, 4
   		
	jr $ra
	
# $a1 -> next pos x
# $a2 -> next pos y

# returns $v0 where 0 means is not an allowed position
#		    1 means is an allowed position
CheckNextPos:
	blt $a1, 23, InvalidPos
	bgt $a1, 41, InvalidPos
	blt $a2, 6, InvalidPos
	bgt $a2, 16, InvalidPos
	beq $a1, 27, FirstWall
	beq $a1, 31, SecondWall
	beq $a2, 13, ThirdWall
	li $v0, 1
	jr $ra
	
FirstWall:
	bgt $a2, 8, InvalidPos
	li $v0, 1
	jr $ra

SecondWall:
	blt $a2, 12, InvalidPos
	li $v0, 1
	jr $ra

ThirdWall:
	bgt $a1, 33, InvalidPos
	li $v0, 1
	jr $ra
	
InvalidPos:
	li $v0, 0
	jr $ra

# Checks if theres a collision between the player end the enemy	
PlayerEnemyCollision:
	beq $s0, $s2, YCollision1
	beq $s0, $s4, YCollision2
	jr $ra
	
YCollision1:
	beq $s1, $s3, FinishCollision1
	jr $ra
	
YCollision2:
	beq $s1, $s5, FinishCollision2
	jr $ra

FinishCollision1:
	li $s2, -1 	# Dont show the enemy 1
	li $s3, -1
	j endCollision
	
FinishCollision2:
	li $s4, -1	#Dont show the enemy 2
	li $s5, -1

endCollision:

	lw $t0, Lives	# Lose a live
	addi $t0, $t0, 1
	sw $t0, Lives
	li $t1, 3
	beq $t0, $t1, EndGame	# If looses all lives lose game

	lw $t0, killedEnemies	# Kill an enemy
	addi $t0, $t0, 1
	sw $t0, killedEnemies
	li $t1, 2
	beq $t0, $t1, NewRoundAux
	
	jr $ra

# New Round logic, starts a new round if the level is <4 the screen shows LU (Level up)	
# If Level == 4 then the program moves to GameWon
NewRoundAux:
	lw $t0, Level
	addi $t0, $t0, 1
	sw $t0, Level
	li $t1, 4
	beq $t0, $t1, GameWon
	sw $zero, killedEnemies
	
	jal ClearBoard
	
	# Letter L
	li $a0, 14
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	li $a0, 14
	li $a1, 26
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	# Letter O
		
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
		
	li $a0, 40
	li $a1, 26
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
		
	li $a0, 50
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	li $a0, 1000 	#
	li $v0, 32	# pause for 1s
	syscall		#
	
	j NewRound

# Makes the entire bitmap display the background color (black)
ClearBoard:
		lw $t0, backgroundColor
		li $t1, 16384 # The number of pixels in the display
	StartCLoop:
		subi $t1, $t1, 4
		addu $t2, $t1, $gp
		sw $t0, ($t2)
		beqz $t1, EndCLoop
		j StartCLoop
	EndCLoop:
		jr $ra

# This is the screen showed when the player wins		
GameWon:
	jal ClearBoard
	# Letter G
	li $a0, 14
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	

	li $a0, 24
	li $a1, 16
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	li $a0, 14
	li $a1, 6
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 19
	li $a1, 16
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 14
	li $a1, 26
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	# Letter G
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	

	li $a0, 50
	li $a1, 16
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
	
	li $a0, 45
	li $a1, 16
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
	
	li $a0, 40
	li $a1, 26
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
	
	j WaitForReset
					
# This is the screen shown when the player loses all his lives							
EndGame:
	jal ClearBoard
	
	# Letter G
	li $a0, 14
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	

	li $a0, 24
	li $a1, 16
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	li $a0, 14
	li $a1, 6
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 19
	li $a1, 16
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine
	
	li $a0, 14
	li $a1, 26
	lw $a2, wallColor
	li $a3, 24
	jal DrawHorizontalLine

	# Letter O
		
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
		
	li $a0, 40
	li $a1, 26
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
		
	li $a0, 40
	li $a1, 6
	lw $a2, wallColor
	li $a3, 50
	jal DrawHorizontalLine
		
	li $a0, 50
	li $a1, 6
	lw $a2, wallColor
	li $a3, 26
	jal DrawVerticalLine
	
	
WaitForReset:		
	li $a0, 10 	#
	li $v0, 32	# pause for 10 milisec
	syscall		#
		
	lw $t0, 0xFFFF0000
	li $t1, 114 # r for reset
	beq $t0, $t1, WaitForReset
		
	j Reset
	
Reset:
	li $t0, 1
	sw $t0, Level
	sw $zero, Lives
	sw $zero, killedEnemies
	li $a0, 1000 	#
	li $v0, 32	# pause for 1s
	syscall		#
	j NewGame
