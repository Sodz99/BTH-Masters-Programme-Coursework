
.section .data
height:  .int 1
width:   .int 1
gametimestr: .asciz "Timer: "       # Display string for the timer
timerstr: .asciz "           "      # Placeholder for timer value
score: .asciz "Score: "             # Display string for the score
format: .asciz "%d"                 # Format for printing numbers
score_cnt: .int 0                   # Current score
newline: .asciz "\n"
snake_len:   .int   0               # Initial snake length
apples_cnt:  .int   0               # Remaining apples
loopcount:   .int   0               # Loop counter for various operations
gametimer: .int 100                 # Initial game timer value
snake_y_direct: .int -1             # Snake's initial Y direction
snake_x_direct: .int 0              # Snake's initial X direction
applex: .int 0                      # X position of the apple
appley: .int 0                      # Y position of the apple
endgameflag: .int 0                 # Flag to indicate game over
appleaten: .int 0                   # Flag to indicate if apple was eaten
x: .int 0                           # General-purpose variable for X 
y: .int 0                           # General-purpose variable for Y
timercnt: .long 100000              # Timer counter for delay

.section .bss
snakex: .space 256                  # Array for snake X positions 
snakey: .space 256                  # Array for snake Y positions


.section .text
        .globl snake_game
        .extern usleep
        .extern printf
        .extern board_put_char
        .extern board_put_str
        .extern board_get_key

# Function to check if the snake's head touches its body
snake_touching:
        # check for snake head eating itself
        push %rbp
        mov %rsp, %rbp

        # Initialize snake head position
        movl snakex, %eax
        movl snakey, %ebx
        movl %eax, x
        movl %ebx, y
        
        # Loop Through the snake's body to check for the collision
        movl snake_len, %ecx
        movl %ecx, loopcount
        subl $1, loopcount

        movl $1, %ebx
        snake_touch_loop:
        movl snakey(, %ebx, 4), %eax
        cmpl %eax, y
        jne noeat
        movl snakex(, %ebx, 4), %eax
        cmpl %eax, x
        jne noeat

        # Collision detected, set game over flag
        movl $1, endgameflag
        jmp endthisloop
        noeat:
        add $1, %ebx
        subl $1, loopcount
        movl $0, endgameflag
        cmpl $0, loopcount
        jne snake_touch_loop
        
        endthisloop:
        pop %rbp
        ret


# Function to remove the tail of the snake
remove_tail:
        push %rbp
        mov %rsp, %rbp
        movl snake_len, %ebx
        subl $1, %ebx
        movl snakex(, %ebx, 4), %edi
        movl snakey(, %ebx, 4), %esi
        movq $' ', %rdx   # Replacing the tail segment with a space
        
        call board_put_char
        pop %rbp
        ret

# Function to draw the snake on the board
draw_snake:
        
        push %rbp
        mov %rsp, %rbp

        movl snake_len, %ecx          # Load snake length
        movl %ecx, loopcount
        xorl %ebx, %ebx               # Start with index 0

        movl $0, x        
        draw_body:
        cmpl $0, loopcount            # If index < 1, draw head
        je draw_head

        # Draw body segments
        movl x, %ebx
        movl snakex(, %ebx, 4), %edi  # Get X position of segment
        movl snakey(, %ebx, 4), %esi  # Get Y position of segment
        movq $'*', %rdx               # Draw body
        
        call board_put_char

        incl x                        # Move to the next segment
        decl loopcount                # Decrementing loop counter
        jmp draw_body

        draw_head:
        movl snakex, %edi             # Get X position of head
        movl snakey, %esi             # Get Y position of head
        movq $'@', %rdx               # Draw head
        
        call board_put_char

        pop %rbp
        ret

# Function to update snake positions based on direction
move_snake_direct:
        push %rbp
        mov %rsp, %rbp

        call remove_tail
        
        # Shift body segments 
        movl snake_len, %eax
        movl %eax, loopcount
        subl $1, loopcount
        
        movl snake_len, %ebx
        subl $1, %ebx

        updateLoop:
                subl $1, %ebx
                movl snakex(, %ebx, 4), %eax          # arr[i-1]
                movl snakey(, %ebx, 4), %ecx 
                addl $1, %ebx
                movl %eax, snakex(, %ebx, 4)          # arr[i] = arr[i-1]
                movl %ecx, snakey(, %ebx, 4)

        subl $1, loopcount
        subl $1, %ebx
        cmpl $0, loopcount
        jne updateLoop
        
	#update head position based on direction
        cmpl $1, snake_x_direct
        jne notright

        addl $1, snakey
        jmp notup

        notright:
        cmpl $0, snake_x_direct
        je notleft
        
        subl $1, snakey
        jmp notup

        notleft:
        cmpl $1, snake_y_direct
        jne notdown

        addl $1, snakex
        jmp notup
        
        notdown:
        cmpl $0, snake_y_direct
        je notup

        subl $1, snakex

        notup:
        pop %rbp                
        ret

#function to check if the snake hits the boundaries
check_boundaries:
        push %rbp
        mov %rsp, %rbp
        movl snake_x_direct, %eax
        movl snake_y_direct, %ebx
        
        # Check if the snake's head collides with the apple
        movl appley, %eax
        cmpl %eax, snakey
        jne nocollide
        movl applex, %eax
        cmpl %eax, snakex
        jne nocollide
        
        # If apple is eaten, update score, timer, and snake length
        addl $1, score_cnt
        subq $10000, timercnt
        addl $1, snake_len
         
        call place_apple
        subl $1, apples_cnt
        
        movl $100, gametimer
        
        nocollide:
        # Check if the snake collides with the boundaries
        movl snake_len, %ebx
        subl $1, %ebx
        movl snakey, %eax
        cmpl $78, %eax                # Check bottom boundary
        jge mov_left
        cmpl $1, %eax                 # Check top boundary
        jle mov_right
        jmp check_updown
        
        mov_right:
        movl $1, endgameflag          # End game if boundary hits
        jmp returnout
        
        mov_left:
        movl $1, endgameflag
        jmp returnout
        
        check_updown:
        movl snake_len, %ebx
        subl $1, %ebx
        movl snakex, %eax
        cmpl $24, %eax                # Check right boundary
        jge mov_down             
        cmpl $1, %eax                 # Check left boundary
        jle mov_up
        jmp returnout

        
        mov_up:
        movl $1, endgameflag
        jmp returnout
        
        mov_down:
        movl $1, endgameflag

        returnout:
        pop %rbp
        ret


snake_mov_keys:
        push %rbp
        mov %rsp, %rbp
        
        # Get key input for movement
        call board_get_key
        
        # Update direction based on arrow key input
        cmpl $0, snake_x_direct
        je left

        cmpl $259, %eax
        jne right

        movl $-1, snake_y_direct
        movl $0, snake_x_direct
        jmp endfun
        
        right:
        cmpl $258, %eax
        jne left
        
        movl $1, snake_y_direct
        movl $0, snake_x_direct
        jmp endfun
        
        left:
        cmpl $0, snake_y_direct
        je endfun

        cmpl $260, %eax
        jne up

        movl $-1, snake_x_direct
        movl $0, snake_y_direct
        jmp endfun
        
        up:
        cmpl $261, %eax
        jne endfun
        
        movl $1, snake_x_direct
        movl $0, snake_y_direct
        
        endfun:
        pop %rbp

        ret

draw_board:
        push %rbp
        mov %rsp, %rbp

        # Draw the top border of the playfield 
        movl $80, loopcount
        movl $1, x
        movl $1, y
toploop:
        movl x, %edi
        movl y, %esi        
        movq $'#', %rdx
        
        call board_put_char
        addl $1, y
        movl loopcount, %ecx
        subl $1, %ecx
        movl %ecx, loopcount
        cmpl $0, %ecx
        jne toploop

        # Draw the bottom border of the playfield
        movl $80, loopcount
        movl $25, x
        movl $1, y
botloop:
        movl x, %edi
        movl y, %esi        
        movq $'#', %rdx
        
        call board_put_char
        addl $1, y 
        movl loopcount, %ecx
        subl $1, %ecx
        movl %ecx, loopcount
        cmpl $0, %ecx
        jne botloop
        
        # Draw the left border of the playfield
        movl $25, loopcount
        movl $1, x
        movl $1, y
leftloop:
        movl x, %edi
        movl y, %esi        
        movq $'#', %rdx
        
        call board_put_char
        addl $1, x
        movl loopcount, %ecx
        subl $1, %ecx
        movl %ecx, loopcount
        cmpl $0, %ecx
        jne leftloop

        # Draw the right border of the playfield
        movl $25, loopcount
        movl $1, x
        movl $80, y
rightloop:
        movl x, %edi
        movl y, %esi        
        movq $'#', %rdx
        
        call board_put_char
        addl $1, x
        movl loopcount, %ecx
        subl $1, %ecx
        movl %ecx, loopcount
        cmpl $0, %ecx
        jne rightloop        
                
        pop %rbp
        ret

place_apple:
        push %rbp
        mov %rsp, %rbp

        # Generate random X and Y positions for the apple        
        call rand                 
        movl $20, %ebx
        xorl %edx, %edx          
        divl %ebx                
        addl $4, %edx
        movl %edx, applex
        
        call rand                
        movl $75, %ebx
        xorl %edx, %edx           
        divl %ebx               
        addl $4, %edx
        movl %edx, appley

        # Place the apple on the board
        movl applex, %edi
        movl appley, %esi
        movq $'o', %rdx 
        
        call board_put_char       
        pop %rbp

        ret

show_score_lives:
        push %rbp
        mov %rsp, %rbp
        
        # Display the score
        leaq score(%rip), %rdi    
        leaq format(%rip), %rsi    
        movl score_cnt, %edx         
        call sprintf
        
        # Display the timer
        leaq timerstr(%rip), %rdi    
        leaq format(%rip), %rsi    
        movl gametimer, %edx         
        call sprintf

        movq $0, %rdi
        movq $8, %rsi
        leaq score(%rip), %rdx
        call board_put_str

      
        movq $0, %rdi
        movq $78, %rsi
        leaq timerstr(%rip), %rdx
        call board_put_str

        pop %rbp
        ret     

snake_game:

        push %rbp
        mov %rsp, %rbp


        # Initialize the game state
        movl %edi, snake_len
        movl %esi, apples_cnt

        call draw_board

        # Set initial snake positions
        movl snake_len, %ecx
        movl $15 , x
        mov $0, %ebx
        initlop:
                movl x, %eax
                movl %eax, snakex(, %ebx, 4)
                movl $40, snakey(, %ebx, 4)

                addl $1, x
                addl $1, %ebx
                subl $1, %ecx
                cmpl $0, %ecx
                jne initlop

        movq $0, %rdi
        movq $1, %rsi
        leaq score(%rip), %rdx
        call board_put_str

        movq $0, %rdi
        movq $70, %rsi
        leaq gametimestr(%rip), %rdx
        call board_put_str
        
        call place_apple
        
        gameloop:
        call snake_touching
        call move_snake_direct
        call draw_snake
        call show_score_lives
        call check_boundaries
        call snake_mov_keys

        movq timercnt, %rdi
        call usleep            
        
        subl $1, gametimer
        cmpl $0, apples_cnt
        je endgame
        cmpl $1, endgameflag
        je endgame
        cmpl $0, gametimer
        je endgame
        jmp gameloop

        endgame:
        pop %rbp
        ret                    
