################ CSC258H1F Fall 2022 Assembly Final Project ##################
# This file contains our implementation of Breakout.
#
# Student 1: Linghui, Hua, 1008306879
# Student 2: Jiaqi He, 1006166248
######################## Bitmap Display Configuration ########################
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 512
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Brick Breaker game.
main:
    # Initialize the game
    li $t1, 0xa9a9a9
    lw $t0, ADDR_DSPL       # $t0 = base address for display
    addi $t4, $zero, 0
    addi $t5, $zero, 248
    
    li $t2, 0xd8bfd8        # $t2 = purple
    li $t3, 0xffc0cb        # $t3 = pink
    li $t4, 0xb0e2ff         # $t4 = blue

    li $t1, 0xb392f0	# $t1 = darker purple
    li $a2, 0xffffff	# $a2 = white
    
    li $a3, 0x000000    # $a3 = black
    li, $s2, 5 #upright =0, downright =1, down left =2, up left =3
    li $t9, 0 #Initialize counter

    li $s7, 0 # Initialize a boolean for indicated which keyboard input

    jal menu   
 
keyboard:    
    li $v0, 32
    li $a0, 1
    syscall

    lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    lw $t7, ADDR_DSPL
    beq $t8, 1, keyboard_input_selection     # If first word 1, key is pressed
    
    jr $ra

draw_stage_one:
    li $t1, 0xa9a9a9  #t1 = grey
    li $t4, 0
    lw $t0, ADDR_DSPL
    jal draw_top_wall_loop
    jal draw_side_wall
    li $t4, 0xb0e2ff

    lw $t0, ADDR_DSPL
    jal draw_bricks_color1
    lw $t0, ADDR_DSPL
    jal draw_bricks_color2
    lw $t0, ADDR_DSPL
    jal draw_bricks_color3
    lw $t0, ADDR_DSPL
    li $t1, 0xb392f0	# $t1 = darker purple
    jal draw_ball_n_paddle
    lw $t0, ADDR_KBRD
    li, $s2, 5 #upright =0, downright =1, down left =2, up left =3
    li $t9, 0 #Initialize counter
    j game_loop

draw_stage_two:
    li $t1, 0xa9a9a9  #t1 = grey
    li $t4, 0
    lw $t0, ADDR_DSPL
    jal draw_top_wall_loop
    jal draw_side_wall
    li $t4, 0xb0e2ff
    lw $t0, ADDR_DSPL
    jal draw_bricks_color1_stage_two
    lw $t0, ADDR_DSPL
    jal draw_bricks_color1_stage_two_2
    lw $t0, ADDR_DSPL
    jal draw_bricks_color2_stage_two
    lw $t0, ADDR_DSPL
    jal draw_bricks_color2_stage_two_2
    lw $t0, ADDR_DSPL
    jal draw_bricks_color3_stage_two
    lw $t0, ADDR_DSPL
    li $t1, 0xb392f0	# $t1 = darker purple
    jal draw_ball_n_paddle
    lw $t0, ADDR_KBRD
    li, $s2, 5 #upright =0, downright =1, down left =2, up left =3
    li $t9, 0 #Initialize counter
    j game_loop

menu:
    lw $t7, ADDR_DSPL
    jal draw_mode
    jal draw_number_1
    jal draw_number_2
    jal draw_number_3
    j keyboard

draw_mode: 
    lw $t7, ADDR_DSPL
    addi $t7, $t7, 72
    sw $a2, 8($t7) # White 
    sw $a2, 16($t7)
    sw $a2, 36($t7)
    sw $a2, 40($t7)
    sw $a2, 56($t7)
    sw $a2, 60($t7)
    sw $a2, 64($t7)
    sw $a2, 80($t7)
    sw $a2, 84($t7)
    sw $a2, 88($t7)
    sw $a2, 92($t7)
    sw $a2, 260($t7)
    sw $a2, 268($t7)
    sw $a2, 276($t7)
    sw $a2, 288($t7)
    sw $a2, 300($t7)
    sw $a2, 312($t7)
    sw $a2, 324($t7)
    sw $a2, 336($t7)
    sw $a2, 516($t7)
    sw $a2, 524($t7)
    sw $a2, 532($t7)
    sw $a2, 544($t7)
    sw $a2, 556($t7)
    sw $a2, 568($t7)
    sw $a2, 580($t7)
    sw $a2, 592($t7)
    sw $a2, 596($t7)
    sw $a2, 600($t7)
    sw $a2, 604($t7)
    sw $a2, 772($t7)
    sw $a2, 788($t7)
    sw $a2, 800($t7)
    sw $a2, 812($t7)
    sw $a2, 824($t7)
    sw $a2, 836($t7)
    sw $a2, 848($t7)
    sw $a2, 1028($t7)
    sw $a2, 1044($t7)
    sw $a2, 1060($t7)
    sw $a2, 1064($t7)
    sw $a2, 1080($t7)
    sw $a2, 1084($t7)
    sw $a2, 1088($t7)
    sw $a2, 1104($t7)
    sw $a2, 1108($t7)
    sw $a2, 1112($t7)
    sw $a2, 1116($t7)
    jr $ra

draw_number_1: 
    lw $t7, ADDR_DSPL
    addi $t7, $t7, 3092
    sw $t2, 12($t7) # Purple
    sw $t2, 264($t7)
    sw $t2, 268($t7)
    sw $t2, 516($t7)
    sw $t2, 524($t7)
    sw $t2, 1036($t7)
    sw $t2, 1292($t7)
    sw $t2, 1548($t7)
    sw $t2, 780($t7)
    sw $t2, 2052($t7)
    sw $t2, 2056($t7)
    sw $t2, 1804($t7)
    sw $t2, 2060($t7)
    sw $t2, 2064($t7)
    sw $t2, 2068($t7)
    jr $ra

draw_number_2: 
    lw $t7, ADDR_DSPL
    addi $t7, $t7, 3184
    sw $t3, 4($t7) # Pink
    sw $t3, 8($t7)
    sw $t3, 12($t7)
    sw $t3, 16($t7)
    sw $t3, 20($t7)
    sw $t3, 276($t7)
    sw $t3, 532($t7) 
    sw $t3, 788($t7) 
    sw $t3, 1028($t7)
    sw $t3, 1032($t7)
    sw $t3, 1036($t7)
    sw $t3, 1040($t7)
    sw $t3, 1044($t7)
    sw $t3, 1284($t7)
    sw $t3, 1540($t7)
    sw $t3, 1796($t7)
    sw $t3, 2052($t7)
    sw $t3, 2056($t7)
    sw $t3, 2060($t7)
    sw $t3, 2064($t7)
    sw $t3, 2068($t7)
    jr $ra

draw_number_3:
    lw $t7, ADDR_DSPL
    addi $t7, $t7, 3276
    sw $t4, 4($t7) # Blue
    sw $t4, 8($t7)
    sw $t4, 12($t7)
    sw $t4, 16($t7)
    sw $t4, 20($t7)
    sw $t4, 276($t7)
    sw $t4, 532($t7) 
    sw $t4, 788($t7) 
    sw $t4, 1028($t7)
    sw $t4, 1032($t7)
    sw $t4, 1036($t7)
    sw $t4, 1040($t7)
    sw $t4, 1044($t7)
    sw $t4, 1300($t7)
    sw $t4, 1556($t7)
    sw $t4, 1812($t7)
    sw $t4, 2052($t7)
    sw $t4, 2056($t7)
    sw $t4, 2060($t7)
    sw $t4, 2064($t7)
    sw $t4, 2068($t7)
    jr $ra

draw_top_wall_loop: 
    beq $t4, 128, END       # Stop the loop at 128 pixel (draw two lines)
    sw $t1, ($t0)          # store grey color value to the display buffer
    addi $t0, $t0, 4        # increment the display buffer address
    addi $t4, $t4, 1        # increment the counter
    j draw_top_wall_loop    # jump to draw_top_wall_loop

draw_side_wall:
   addi $t6, $zero, 0
draw_side_walls_loop:
    beq $t6, 30, END        
    sw $t1, ($t0)          # store grey color value to the display buffe
    addi $t0, $t0, 4        # increment the display buffer address
    sw $t1, ($t0)          # store grey color value to the display buffer
    addi $t0, $t0, 244        # increment the display buffer address
    
    sw $t1, ($t0)          # store grey color value to the display buffer
    addi $t0, $t0, 4        # increment the display buffer address
    sw $t1, ($t0)          # store grey color value to the display buffer
    addi $t0, $t0, 4        # increment the display buffer address
    addi $t6, $t6, 1        # increment the counter
    j draw_side_walls_loop  # jump to draw_side_walls_loop

END: jr $ra

draw_bricks_color1:
    addi $t6, $zero, 0
    addi $t0, $t0, 520
draw_bricks_loop_color1:
    beq $t6, 15, END
    sw $t2, ($t0)
    addi $t0, $t0, 4 
    sw $t2, ($t0)
    addi $t0, $t0, 4
    sw $t2, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color1
    
draw_bricks_color2:
    addi $t6, $zero, 0
    addi $t0, $t0, 1036 
draw_bricks_loop_color2:
    beq $t6, 15, END
    sw $t3, ($t0)
    addi $t0, $t0, 4 
    sw $t3, ($t0)
    addi $t0, $t0, 4
    sw $t3, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color2
    
draw_bricks_color3:
    addi $t6, $zero, 0
    addi $t0, $t0, 1544
draw_bricks_loop_color3:
    beq $t6, 15, END
    sw $t4, ($t0)
    addi $t0, $t0, 4 
    sw $t4, ($t0)
    addi $t0, $t0, 4
    sw $t4, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color3

draw_bricks_color1_stage_two:
    addi $t6, $zero, 0
    addi $t0, $t0, 520
draw_bricks_loop_color1_stage_two:
    beq $t6, 15, END
    sw $t2, ($t0)
    addi $t0, $t0, 4 
    sw $t2, ($t0)
    addi $t0, $t0, 4
    sw $t2, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color1_stage_two
draw_bricks_color1_stage_two_2:
    addi $t6, $zero, 0
    addi $t0, $t0, 776
draw_bricks_loop_color1_stage_two_2:
    beq $t6, 15, END
    sw $t2, ($t0)
    addi $t0, $t0, 4 
    sw $t2, ($t0)
    addi $t0, $t0, 4
    sw $t2, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color1_stage_two_2

draw_bricks_color2_stage_two:
    addi $t6, $zero, 0
    addi $t0, $t0, 1032 
draw_bricks_loop_color2_stage_two:
    beq $t6, 15, END
    sw $t3, ($t0)
    addi $t0, $t0, 4 
    sw $t3, ($t0)
    addi $t0, $t0, 4
    sw $t3, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color2_stage_two

draw_bricks_color2_stage_two_2:
    addi $t6, $zero, 0
    addi $t0, $t0, 1288 
draw_bricks_loop_color2_stage_two_2:
    beq $t6, 15, END
    sw $t3, ($t0)
    addi $t0, $t0, 4 
    sw $t3, ($t0)
    addi $t0, $t0, 4
    sw $t3, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color2_stage_two_2

draw_bricks_color3_stage_two:
    addi $t6, $zero, 0
    addi $t0, $t0, 1544
draw_bricks_loop_color3_stage_two:
    beq $t6, 15, END
    sw $t4, ($t0)
    addi $t0, $t0, 4 
    sw $t4, ($t0)
    addi $t0, $t0, 4
    sw $t4, ($t0)
    addi $t0, $t0, 4 #the last empty
    addi $t0, $t0, 4
    addi $t6, $t6, 1        # increment the counter
    j draw_bricks_loop_color3_stage_two

draw_ball_n_paddle:
    lw $t0, ADDR_DSPL
    sw $a2, 7804($t0)
    addi $s1, $zero, 7804  # Store the address of the ball
draw_paddle: 
    addi $t6, $zero, 0
    addi $t0, $t0, 8040
    addi $s0, $s0, 8040  # Store the address of the beginning of the paddle
draw_paddle_loop: 
    beq $t6, 11, END
    sw $t1, ($t0)
    addi $t0, $t0, 4
    addi $t6, $t6, 1
    j draw_paddle_loop

keyboard_input_selection: 
    beq $s7, 0, keyboard_input_menu
    beq $s7, 1, keyboard_input_game
    beq $s7, 2, keyboard_input_restart
    beq $s7, 3, keyboard_input_game_3

keyboard_input_menu:                     # A key is pressed
    lw $a0, 4($t0)                  # Load second word from keyboard
    beq $a0, 0x31, respond_to_1     # Check if the key 1 was pressed, if so quit the game
    beq $a0, 0x32, respond_to_2     # Check if the key 2 was pressed
    beq $a0, 0x33, respond_to_3     # Check if the key 3 was pressed
    li $v0, 1                      # ask system to print $a0
    syscall
    
    b keyboard

respond_to_1:
    li $s7, 1   # Change the a boolean to enter game loop
    li $t6, 0
    lw $t7, ADDR_DSPL
    jal clear
    j draw_stage_one
    
respond_to_2:
    li $s7, 1
    li $t6, 0
    lw $t7, ADDR_DSPL
    jal clear
    j draw_stage_two

respond_to_3:
    li $s7, 3
    li $t6, 0
    lw $t7, ADDR_DSPL
    jal clear
    j draw_stage_three

reset_s0:
    li $s0, 8040
    jr $ra

keyboard_input_game:                     # A key is pressed
    lw $a0, 4($t0) 		# Load second word from keyboard
    bgt $s0, 8148, reset_s0                # reset s0 after restarting the game
    beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed, if so quit the game
    beq $a0, 0x61, respond_to_A     # Check if the key a was pressed
    beq $a0, 0x64, respond_to_D     # Check if the key d was pressed
    beq $a0, 0x20, respond_to_space #check if key space was pressed, if so start the game
    li $v0, 1                      # ask system to print $a0
    syscall
    
    b keyboard

respond_to_Q:
    j exit
    
respond_to_space:
    li, $s2, 0
    li $s6, 1
    b game_loop
    
respond_to_A: 
    lw $t7, ADDR_DSPL
    beq $s0, 7944, keyboard
    addi $t6, $zero, 0
    add $t7, $t7, $s0
    jal clear_paddle
    addi $t6, $zero, 0
    lw $t7, ADDR_DSPL
    subi $s0, $s0, 4         # Update the address of head of paddle (one pixel left)
    add $t7, $t7, $s0       
    jal redraw_paddle
    b game_loop    
    
respond_to_D: 
   lw $t7, ADDR_DSPL
   beq $s0, 8140, keyboard
   addi $t6, $zero, 0
   add $t7, $t7, $s0
   jal clear_paddle
   addi $t6, $zero, 0
   lw $t7, ADDR_DSPL
   addi $s0, $s0, 4          # Update the address of head of paddle (one pixel right)
   add $t7, $t7, $s0
   jal redraw_paddle
   b game_loop
   
keyboard_input_restart:
   lw $a0, 4($t0)                  # Load second word from keyboard
   beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed, if so quit the game
   beq $a0, 0x72, respond_to_R #check if key space was pressed, if so start the game
   li $v0, 1                      # ask system to print $a0
   syscall
    
   b keyboard

respond_to_R: 
   li $s7, 0 # reset the boolean to menu option
   li $t6, 0
   lw $t7, ADDR_DSPL
   jal clear # clear the board
   j menu

clear_paddle: 
   beq $t6, 11, END
   sw $a3, ($t7)
   addi $t7, $t7, 4
   addi $t6, $t6, 1
   j clear_paddle
   
redraw_paddle:
   beq $t6, 11, END
   sw $t1, ($t7)
   addi $t7, $t7, 4
   addi $t6, $t6, 1
   j redraw_paddle


clear_ball:
    lw $t7, ADDR_DSPL
    add $t7, $t7, $s1
    sw $a3, ($t7)
    jr $ra
    
delay_ball: 
    li $v0, 32    #Load the delay syscall number into $v0
	li $a0, 1000   #Set the delay time (in cycles)
  	 syscall
	jr $ra

upright: 
    li $s2, 0 
    jr $ra
    
upleft:
    li $s2, 3
    jr $ra 

downright: 
    li $s2, 1
    jr $ra 

downleft:
    li $s2, 2
    jr $ra 
        
redraw_ball_upright:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 244	#if the remainder is 244, hits the right wall
    beq $t5, $t6, upleft #Check right boundary and change directio#n
    li $t6, 776    #Up boundary
    blt $s1, $t6, downright #Check up boundary and change direction   
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)			#Clear the ball (end)
    subi $s1, $s1, 252		#Update the address of the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop
    
redraw_ball_upleft:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6	
    mfhi $t5
    li, $t6, 8		#if the remainder is 8, hits the left wall
    beq $t5, $t6, upright #Check left boundary and change direction
    li $t6, 776    #Up boundary
   blt $s1, $t6, downleft #Check up boundary and change direction
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    subi $s1, $s1, 260      #Update the address of the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop
    
redraw_ball_downright:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 244	#if the remainder is 244, hits the right wall
    beq $t5, $t6, downleft #Check right boundary and change direction
    lw $t7, ADDR_DSPL		#set $t7 as the address	of the display
    add, $t5, $s1, $t7 #get the address of the ball on display
    lw, $t6, 256($t5)   #find the color under the ball
    beq, $t6, $t1, upright     #if the pixel under the ball equal to the color of the paddle, bounce
    #bgt $s1, $t6, upright #Check low boundary and change direction
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    addi $s1, $s1, 260      #Update the address of the ball

    add $t7, $t7, $s1
    sw $a2, ($t7)           #Redraw the ball in updated address
    b game_loop
    
redraw_ball_downleft:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 8	#if the remainder is 8, hits the left wall
    beq $t5, $t6, downright #Check left boundary and change direction
    lw $t7, ADDR_DSPL		#set $t7 as the address	
    add, $t5, $s1, $t7 #get the address of the ball on display
    lw $t6, 256($t5)   #find the color under the ball
    beq $t6, $t1, upleft     #if the pixel under the ball equal to the color of the paddle, bounce
    # li $t6, 7656    #Low boundary
    # bgt $s1, $t6, upleft #Check low boundary and change direction
                            #Start clear_ball (reset all register)
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    addi $s1, $s1, 252      #Update the address of the ball
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop
 
check_next_position:
    beq $s2, 0, next_ball_upright #upright =0, downright =1, down left =2, up left =3
    beq $s2, 1, next_ball_downright         #check the ball's next position
    beq $s2, 2, next_ball_downleft
    beq $s2, 3, next_ball_upleft
    
next_ball_upright:
    addi, $s3, $s1, -252
    j check_collision

next_ball_upleft:
    addi, $s3, $s1, -260
    j check_collision

next_ball_downright:
    addi, $s3, $s1, 260
    j check_collision

next_ball_downleft:
    addi, $s3, $s1, 252
    j check_collision

check_collision: 
    li $t2, 0xd8bfd8        # $t2 = purple
    li $t3, 0xffc0cb        # $t3 = pink
    li $t4, 0xb0e2ff         # $t4 = blue
    add, $s4, $zero, $s3    # Initialized a register for finding head of bricks
    li $s5, 0                # Initialized a register for a boolean value
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s3, $t7
    lw $t6, ($t5)
    beq $t6, $t3, find_head_pink
    beq $t6, $t4, find_head_blue
    beq $t6, $t2, find_head_purple
    beq $s5, 1, erase_bricks
    beq $s5, 1, change_direction
    jr $ra

find_head_purple: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t2, erase_bricks
    subi $s4, $s4, 4
    j find_head_purple

find_head_pink: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t3, erase_bricks
    subi $s4, $s4, 4
    j find_head_pink

find_head_blue: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t4, erase_bricks
    subi $s4, $s4, 4
    j find_head_blue

erase_bricks: 
    sw $a3, 4($t5)
    sw $a3, 8($t5)
    sw $a3, 12($t5)
    j change_direction

change_direction: 
    beq $s2, 0, cd_upright   # Change direction in this way: rightup -> rightdown 0->1 
    beq $s2, 1, cd_downright    # 1->0 
    beq $s2, 2, cd_downleft     # leftdown -> leftup 2->3
    beq $s2, 3, cd_upleft       # 3->2
    jr $ra

cd_upright: 
    li $s2, 1
    b game_loop

cd_downright: 
    li $s2, 0
    b game_loop

cd_downleft: 
    li $s2, 3
    b game_loop

cd_upleft: 
    li $s2, 2
    b game_loop

game_over: 
   li, $t6, 0
   lw, $t7, ADDR_DSPL
   jal clear_board
  
clear: 
    beq $t6, 2050, END
    sw $a3, 0($t7)          # store black color value to the display buffer
    addi $t7, $t7, 4        # increment the display buffer address
    addi $t6, $t6, 1        # increment the counter
    j clear

clear_board: 
    beq $t6, 2050, print_game_over
    sw $a3, 0($t7)          # store black color value to the display buffer
    addi $t7, $t7, 4        # increment the display buffer address
    addi $t6, $t6, 1        # increment the counter
    j clear_board           # jump to clear_board
    
print_game_over:
   lw, $t7, ADDR_DSPL
   addi $t7, $t7, 3616
   sw $a2, 8($t7)
   sw $a2, 12($t7)
   sw $a2, 32($t7)
   sw $a2, 52($t7)
   sw $a2, 60($t7)
   sw $a2, 72($t7)
   sw $a2, 76($t7)
   sw $a2, 80($t7)
   sw $a2, 84($t7)
   sw $a2, 108($t7)
   sw $a2, 112($t7)
   sw $a2, 124($t7)
   sw $a2, 140($t7)
   sw $a2, 148($t7)
   sw $a2, 152($t7)
   sw $a2, 156($t7)
   sw $a2, 160($t7)
   sw $a2, 168($t7)
   sw $a2, 172($t7)
   sw $a2, 176($t7)
   sw $a2, 260($t7)
   sw $a2, 284($t7)
   sw $a2, 292($t7)
   sw $a2, 304($t7)
   sw $a2, 312($t7)
   sw $a2, 320($t7)
   sw $a2, 328($t7)
   sw $a2, 360($t7)
   sw $a2, 372($t7)
   sw $a2, 380($t7)
   sw $a2, 396($t7)
   sw $a2, 404($t7)
   sw $a2, 424($t7)
   sw $a2, 436($t7)
   sw $a2, 516($t7)
   sw $a2, 524($t7)
   sw $a2, 528($t7)
   sw $a2, 536($t7)
   sw $a2, 540($t7)
   sw $a2, 544($t7)
   sw $a2, 548($t7)
   sw $a2, 552($t7)
   sw $a2, 560($t7)
   sw $a2, 568($t7)
   sw $a2, 576($t7)
   sw $a2, 584($t7)
   sw $a2, 588($t7)
   sw $a2, 592($t7)
   sw $a2, 596($t7)
   sw $a2, 616($t7)
   sw $a2, 628($t7)
   sw $a2, 640($t7)
   sw $a2, 648($t7)
   sw $a2, 660($t7)
   sw $a2, 664($t7)
   sw $a2, 668($t7)
   sw $a2, 672($t7)
   sw $a2, 680($t7)
   sw $a2, 684($t7)
   sw $a2, 688($t7)
   sw $a2, 772($t7)
   sw $a2, 784($t7)
   sw $a2, 792($t7)
   sw $a2, 808($t7)
   sw $a2, 816($t7)
   sw $a2, 832($t7)
   sw $a2, 840($t7)
   sw $a2, 872($t7)
   sw $a2, 884($t7)
   sw $a2, 896($t7)
   sw $a2, 904($t7)
   sw $a2, 916($t7)
   sw $a2, 936($t7)
   sw $a2, 944($t7)
   sw $a2, 1032($t7)
   sw $a2, 1036($t7)
   sw $a2, 1048($t7)
   sw $a2, 1064($t7)
   sw $a2, 1072($t7)
   sw $a2, 1088($t7)
   sw $a2, 1096($t7)
   sw $a2, 1100($t7)
   sw $a2, 1104($t7)
   sw $a2, 1108($t7)
   sw $a2, 1132($t7)
   sw $a2, 1136($t7)
   sw $a2, 1156($t7)
   sw $a2, 1172($t7)
   sw $a2, 1176($t7)
   sw $a2, 1180($t7)
   sw $a2, 1184($t7)
   sw $a2, 1192($t7)
   sw $a2, 1204($t7) 
   li $s7, 2
   j restart_loop
   
restart_loop: 
   bne $s7, 2, END
   jal keyboard
   j restart_loop
   
exit:
    li $v0, 10              # terminate the program gracefully
    syscall
    
game_loop:
    jal keyboard
    
    addi, $t9, $t9, 1
    beq $t9, 50, ball_loop
# 	1a. Check if key has been pressed
#         1b. Check which key has been pressed
#   2a. Check for collisions
# 	2b. Update locations (paddle, ball)

# 	3. Draw the screen
# 	4. Sleep
#     5. Go back to 1
    li $t6, 8168    #Low boundary
    bgt $s1, $t6, game_over
    b game_loop


game_loop_3:
    jal keyboard
    
    addi, $t9, $t9, 1
    beq $t9, 50, ball_loop_3
# 	1a. Check if key has been pressed
#         1b. Check which key has been pressed
#   2a. Check for collisions
# 	2b. Update locations (paddle, ball)

# 	3. Draw the screen
# 	4. Sleep
#     5. Go back to 1
    li $t6, 8168    #Low boundary
    bgt $s1, $t6, game_over
    b game_loop_3

ball_loop:
    li $t9, 0
    jal check_next_position
    beq $s2, 0, redraw_ball_upright #upright =0, downright =1, down left =2, up left =3
    beq $s2, 1, redraw_ball_downright
    beq $s2, 2, redraw_ball_downleft
    beq $s2, 3, redraw_ball_upleft
    b game_loop

ball_loop_3:
    li $t9, 0
    jal check_next_position_3
    beq $s2, 0, redraw_ball_upright_3 #upright =0, downright =1, down left =2, up left =3
    beq $s2, 1, redraw_ball_downright_3
    beq $s2, 2, redraw_ball_downleft_3
    beq $s2, 3, redraw_ball_upleft_3
    b game_loop_3

draw_stage_three:
    li $t1, 0xa9a9a9  #t1 = grey
    li $t4, 0
    lw $t0, ADDR_DSPL
    jal draw_top_wall_loop
    jal draw_side_wall
    li $t4, 0xb0e2ff

    lw $t0, ADDR_DSPL
    jal draw_bricks_color1
    lw $t0, ADDR_DSPL
    jal draw_bricks_color2
    lw $t0, ADDR_DSPL
    jal draw_bricks_color3
    lw $t0, ADDR_DSPL
    li $t1, 0xb392f0	# $t1 = darker purple
    jal draw_ball_n_paddle
    lw $t0, ADDR_KBRD
    li, $s2, 5 #upright =0, downright =1, down left =2, up left =3
    li $t9, 0 #Initialize counter
    j game_loop_3

check_next_position_3:
    beq $s2, 0, next_ball_upright_3 #upright =0, downright =1, down left =2, up left =3
    beq $s2, 1, next_ball_downright_3         #check the ball's next position
    beq $s2, 2, next_ball_downleft_3
    beq $s2, 3, next_ball_upleft_3

next_ball_upright_3:
    addi, $s3, $s1, -252
    j check_collision_3

next_ball_upleft_3:
    addi, $s3, $s1, -260
    j check_collision_3

next_ball_downright_3:
    addi, $s3, $s1, 260
    j check_collision_3

next_ball_downleft_3:
    addi, $s3, $s1, 252
    j check_collision_3

check_collision_3: 
    li $t2, 0xd8bfd8        # $t2 = purple
    li $t3, 0xffc0cb        # $t3 = pink
    li $t4, 0xb0e2ff         # $t4 = blue
    add, $s4, $zero, $s3    # Initialized a register for finding head of bricks
    
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s3, $t7
    lw $t6, ($t5)
    beq $t6, $a2, find_head_white
    beq $t6, $t3, find_head_pink_3
    beq $t6, $t4, find_head_blue_3
    beq $t6, $t2, find_head_purple_3
    

    jr $ra

find_head_purple_3: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t2, erase_bricks_white_3
    subi $s4, $s4, 4
    j find_head_purple_3

find_head_pink_3: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t3, erase_bricks_white_3
    subi $s4, $s4, 4
    j find_head_pink_3

find_head_blue_3: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $t4, erase_bricks_white_3
    subi $s4, $s4, 4
    j find_head_blue_3

erase_bricks_white_3: 
    sw $a2, 4($t5)
    sw $a2, 8($t5)
    sw $a2, 12($t5)
    j change_direction_3

find_head_white: 
    lw $t7, ADDR_DSPL        #set $t7 as the address    
    add, $t5, $s4, $t7
    lw $t6, ($t5)
    bne $t6, $a2, erase_bricks_3
    subi $s4, $s4, 4
    j find_head_white

erase_bricks_3: 
    sw $a3, 4($t5)
    sw $a3, 8($t5)
    sw $a3, 12($t5)
    j change_direction_3

change_direction_3: 
    beq $s2, 0, cd_upright_3   # Change direction in this way: rightup -> rightdown 0->1 
    beq $s2, 1, cd_downright_3    # 1->0 
    beq $s2, 2, cd_downleft_3     # leftdown -> leftup 2->3
    beq $s2, 3, cd_upleft_3       # 3->2
    jr $ra

cd_upright_3: 
    li $s2, 1
    b game_loop_3

cd_downright_3: 
    li $s2, 0
    b game_loop_3

cd_downleft_3: 
    li $s2, 3
    b game_loop_3

cd_upleft_3: 
    li $s2, 2
    b game_loop_3

redraw_ball_upright_3:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 244	#if the remainder is 244, hits the right wall
    beq $t5, $t6, upleft #Check right boundary and change directio#n
    li $t6, 776    #Up boundary
    blt $s1, $t6, downright #Check up boundary and change direction   
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)			#Clear the ball (end)
    subi $s1, $s1, 252		#Update the address of the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop_3
    
redraw_ball_upleft_3:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6	
    mfhi $t5
    li, $t6, 8		#if the remainder is 8, hits the left wall
    beq $t5, $t6, upright #Check left boundary and change direction
    li $t6, 776    #Up boundary
   blt $s1, $t6, downleft #Check up boundary and change direction
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    subi $s1, $s1, 260      #Update the address of the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop_3
    
redraw_ball_downright_3:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 244	#if the remainder is 244, hits the right wall
    beq $t5, $t6, downleft #Check right boundary and change direction
    lw $t7, ADDR_DSPL		#set $t7 as the address	of the display
    add, $t5, $s1, $t7 #get the address of the ball on display
    lw, $t6, 256($t5)   #find the color under the ball
    beq, $t6, $t1, upright     #if the pixel under the ball equal to the color of the paddle, bounce
    #bgt $s1, $t6, upright #Check low boundary and change direction
    lw $t7, ADDR_DSPL		#Start clear_ball (reset all register)	
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    addi $s1, $s1, 260      #Update the address of the ball

    add $t7, $t7, $s1
    sw $a2, ($t7)           #Redraw the ball in updated address
    b game_loop_3
    
redraw_ball_downleft_3:
    li $t6, 256     #set up divisor for checking the remainder
    div $s1, $t6
    mfhi $t5
    li, $t6, 8	#if the remainder is 8, hits the left wall
    beq $t5, $t6, downright #Check left boundary and change direction
    lw $t7, ADDR_DSPL		#set $t7 as the address	
    add, $t5, $s1, $t7 #get the address of the ball on display
    lw $t6, 256($t5)   #find the color under the ball
    beq $t6, $t1, upleft     #if the pixel under the ball equal to the color of the paddle, bounce
    # li $t6, 7656    #Low boundary
    # bgt $s1, $t6, upleft #Check low boundary and change direction
                            #Start clear_ball (reset all register)
    add $t7, $t7, $s1
    sw $a3, ($t7)            #clear the ball
    lw $t7, ADDR_DSPL       #Reset and redraw the ball in updated location
    addi $s1, $s1, 252      #Update the address of the ball
    add $t7, $t7, $s1
    sw $a2, ($t7)       #Redraw the ball in updated address
    b game_loop_3



keyboard_input_game_3:                     # A key is pressed
    lw $a0, 4($t0) 		# Load second word from keyboard
    bgt $s0, 8148, reset_s0                # reset s0 after restarting the game
    beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed, if so quit the game
    beq $a0, 0x61, respond_to_A_3     # Check if the key a was pressed
    beq $a0, 0x64, respond_to_D_3     # Check if the key d was pressed
    beq $a0, 0x20, respond_to_space_3 #check if key space was pressed, if so start the game
    li $v0, 1                      # ask system to print $a0
    syscall
    
    b keyboard


respond_to_space_3:
    li, $s2, 0
    li $s6, 1
    b game_loop_3
    
respond_to_A_3: 
    lw $t7, ADDR_DSPL
    beq $s0, 7944, keyboard
    addi $t6, $zero, 0
    add $t7, $t7, $s0
    jal clear_paddle
    addi $t6, $zero, 0
    lw $t7, ADDR_DSPL
    subi $s0, $s0, 4         # Update the address of head of paddle (one pixel left)
    add $t7, $t7, $s0       
    jal redraw_paddle
    b game_loop_3    
    
respond_to_D_3: 
   lw $t7, ADDR_DSPL
   beq $s0, 8140, keyboard
   addi $t6, $zero, 0
   add $t7, $t7, $s0
   jal clear_paddle
   addi $t6, $zero, 0
   lw $t7, ADDR_DSPL
   addi $s0, $s0, 4          # Update the address of head of paddle (one pixel right)
   add $t7, $t7, $s0
   jal redraw_paddle
   b game_loop_3