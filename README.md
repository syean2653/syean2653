Assembly Language - Average of Five Numbers(다섯 숫자 평균)
1. Project Overview

This project is an Assembly Language program developed using Microsoft Visual Studio and MASM (Microsoft Macro Assembler).

The purpose of this program is to receive five integers from the user, calculate their average, and display the result.

2. Development Environment
IDE: Microsoft Visual Studio
Language: Assembly Language
Assembler: MASM (Microsoft Macro Assembler)
Platform: x64
Runtime Library: C Runtime Library
3. Program Features
Receive five integers from the user.
Calculate the sum of the five integers.
Divide the sum by 5 to calculate the average.
Display the average with two decimal places.
4. Algorithm
Initialize the sum to 0.
Initialize the input counter to 1.
Receive an integer from the user.
Add the input integer to the sum.
Increase the counter by 1.
Repeat steps 3-5 until five integers have been entered.
Divide the sum by 5.
Display the calculated average.
5. Example Output
text
Enter 5 integers:
Number 1: 10
Number 2: 20
Number 3: 30
Number 4: 40
Number 5: 50

Average = 30.00

6. Instructions Used
Instruction	Description
MOV	Move data
ADD	Add two values
INC	Increment by one
CMP	Compare two values
JL	Jump if less
CVTSI2SD	Convert integer to double
DIVSD	Divide floating-point values
CALL	Call a function
RET	Return from a procedure
7. Expected Result

The program successfully receives five integers, calculates their sum, divides the sum by five, and displays the average with two decimal places.

8. Files
text
Assembly-Average/
├── main.asm
└── README.md

9. Author

Assembly Language Assignment
