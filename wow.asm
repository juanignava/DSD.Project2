.data
	killedEnemies:		.word 0
	Level:			.word 4 # 0 for main window
					# 1, 2 and 3 for the repective level
	bulletColor:		.word 0x00ffff00 # Yellow
	playerColor:		.word 0x0000ff00 # Green
	enemyColor:		.word 0x00ff0000 # Red
	backgroundColor:	.word 0x00000000 # Black
	wallColor:		.word 0x00ffffff # White
	radarColor:		.word 0x0000ffbf # LightGreen
	
	
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
	
	
NewRound:

	jal ClearBoard
	
	# Draw Level
	lw $a2, Level
	li $a3, 3
	jal DrawDots
	
	# Draw Killed Enemies
	lw $a2, killedEnemies
	li $a3, 34
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
	
	# Draw players (initial)
	
	# Draw enemies (initial)
	
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
	
	
	
	# Dra player in rada (initial)
	
	# Draw enemies in radar (initial)
	
DrawObjects:
	# Check for collisions
	# Move bullet
	
	# Redraw player
	# Redraw player in radar
	
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
	
	# Search for the pushed button for the respective option
	sw $zero, 0xFFFF0000
	j Standby
	
EndStandby:
	j DrawObjects
	
	

# $a2 contains the level number
# $a3 contains the column of the leftmost level dot

DrawDots: #Used for levels and killed enemies

		addi $sp, $sp, -12	# Stores regiester values to the stack
   		sw $ra, 0($sp)
   		sw $s2, 4($sp)
   		sw $a2, 8($sp)
   		
   		move $s2, $a2
   		lw $a2, playerColor
   		
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