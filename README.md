#1
Assembly Language - Student Information Output
1. 프로젝트 소개 (Project Overview)

이 프로젝트는 Assembly Language를 사용하여 학번과 이름을 Windows 콘솔에 출력하는 프로그램입니다.

MASM(Microsoft Macro Assembler)을 사용하여 구현하였으며, 한글이 깨지지 않도록 Unicode(UTF-16) 형식으로 문자열을 저장하고 WriteConsoleW 함수를 이용하여 출력합니다.

2. 개발 환경 (Development Environment)
IDE: Microsoft Visual Studio
Language: Assembly Language
Assembler: MASM (Microsoft Macro Assembler)
Platform: x86 (32-bit)
Model: Flat
Calling Convention: stdcall
Operating System: Windows
3. 프로그램 기능 (Program Features)
학번을 콘솔에 출력합니다.
이름을 콘솔에 출력합니다.
한글 문자열을 유니코드 형식으로 저장합니다.
Windows API의 GetStdHandle 함수를 사용하여 콘솔 출력 핸들을 가져옵니다.
WriteConsoleW 함수를 사용하여 한글과 숫자를 출력합니다.
ExitProcess 함수를 사용하여 프로그램을 종료합니다.
4. 실행 결과 (Execution Result)
Console Output
text
학번: 2025964025
이름: 손예안

실행 결과 설명
학번: 2025964025
이름: 손예안

프로그램 실행 시 위와 같이 학번과 이름이 Windows 콘솔 화면에 출력됩니다.

한글 문자열은 Unicode 형식으로 저장되어 정상적으로 출력됩니다.

5. 주요 코드 설명 (Code Explanation)
① 어셈블리 환경 설정
asm
.386
.model flat, stdcall
.stack 4096

.386: 80386 이상 프로세서 명령어 사용
.model flat: 32비트 평면 메모리 모델 설정
stdcall: 함수 호출 규약 설정
.stack 4096: 스택 크기를 4096바이트로 설정
② Windows API 선언
asm
ExitProcess   PROTO, dwExitCode:DWORD
GetStdHandle  PROTO, nStdHandle:DWORD
WriteConsoleW PROTO, hOut:DWORD, lpBuf:DWORD, nChars:DWORD, lpWritten:DWORD, lpReserved:DWORD


Windows API 함수를 사용하기 위해 프로토타입을 선언합니다.

GetStdHandle: 표준 출력 핸들을 가져옵니다.
WriteConsoleW: 유니코드 문자열을 콘솔에 출력합니다.
ExitProcess: 프로그램을 종료합니다.
③ 유니코드 문자열 저장
asm
msg WORD 0D559h, 0BC88h, ':', ' '
    WORD '2','0','2','5','9','6','4','0','2','5'
    WORD 0Dh, 0Ah
    WORD 0C774h, 0B984h, ':', ' '
    WORD 0C190h, 0C608h, 0C548h
    WORD 0Dh, 0Ah

WORD: 2바이트 단위로 데이터를 저장합니다.
한글 문자를 UTF-16 코드 단위로 저장합니다.
0Dh, 0Ah: 줄바꿈을 나타냅니다.
msg: 출력할 학번과 이름을 저장하는 문자열입니다.
④ 문자열 길이 계산
asm
msgLen = ($ - msg) / 2


문자열 전체 바이트 수를 2로 나누어 UTF-16 코드 단위 개수를 계산합니다.

⑤ 콘솔 출력 핸들 가져오기
asm
INVOKE GetStdHandle, -11
mov hOut, eax


GetStdHandle 함수를 호출하여 표준 출력 핸들을 가져온 후 hOut에 저장합니다.

⑥ 학번과 이름 출력
asm
INVOKE WriteConsoleW, hOut, ADDR msg, msgLen, ADDR written, 0


WriteConsoleW 함수를 사용하여 저장된 유니코드 문자열을 콘솔에 출력합니다.

⑦ 프로그램 종료
asm
INVOKE ExitProcess, 0


프로그램을 정상적으로 종료합니다.

6. 사용한 주요 명령어 및 함수
명령어 및 함수	기능
MOV	데이터 이동
INVOKE	프로시저 및 API 함수 호출
ADDR	변수의 주소 전달
GetStdHandle	표준 입출력 핸들 가져오기
WriteConsoleW	유니코드 문자열 출력
ExitProcess	프로그램 종료
7. 프로그램 실행 과정 (Execution Process)
프로그램을 시작합니다.
Windows API를 호출할 수 있도록 환경을 설정합니다.
학번과 이름을 유니코드 형식으로 저장합니다.
GetStdHandle을 통해 표준 출력 핸들을 가져옵니다.
WriteConsoleW를 호출하여 학번과 이름을 출력합니다.
ExitProcess를 호출하여 프로그램을 종료합니다.
8. 프로젝트 파일 구조 (Project Structure)
text
Assembly-Student-Info/
│
├── main.asm
└── README.md

9. 결론 (Conclusion)

이번 프로젝트를 통해 Assembly Language에서 데이터를 저장하고 Windows API를 활용하여 콘솔에 출력하는 방법을 학습하였습니다.

특히 한글이 깨지지 않도록 Unicode(UTF-16) 형식으로 문자열을 저장하고, WriteConsoleW 함수를 사용하여 한글과 숫자를 정상적으로 출력하는 방법을 이해할 수 있었습니다.

또한 GetStdHandle을 이용한 콘솔 핸들 관리와 ExitProcess를 통한 프로그램 종료 과정을 학습하였습니다.

--------------------------------------------------------
#2
MASM - Average of Five Integers
1. Project Overview

This project is an x86 Assembly Language program developed using Microsoft Visual Studio and MASM (Microsoft Macro Assembler).

The program receives five signed integers from the user, calculates their sum, divides the sum by five, and displays the average with two decimal places.

2. Development Environment
IDE: Microsoft Visual Studio
Assembler: MASM (Microsoft Macro Assembler)
Language: x86 Assembly
Architecture: 32-bit (Win32)
Memory Model: Flat
Calling Convention: stdcall / cdecl
Runtime Library: Microsoft C Runtime Library
3. Program Features
Receive five integers from the user.
Validate each input.
Calculate the sum using a 64-bit signed integer.
Calculate the average using the x87 FPU.
Display the average with two decimal places.
Handle invalid input.
4. Execution Result
Example 1: Normal Input

Input and Output

text
Enter 5 integers:
Number 1: 10
Number 2: 20
Number 3: 30
Number 4: 40
Number 5: 50

Average = 30.00

Example 2: Decimal Average

Input and Output

text
Enter 5 integers:
Number 1: 10
Number 2: 15
Number 3: 20
Number 4: 25
Number 5: 30

Average = 20.00

Example 3: Negative Numbers

Input and Output

text
Enter 5 integers:
Number 1: -10
Number 2: 20
Number 3: -5
Number 4: 15
Number 5: 30

Average = 10.00

5. Calculation Process

The average is calculated using the following algorithm:

Initialize the sum to zero.
Receive five integers.
Add each integer to the 64-bit sum.
Divide the total sum by five.
Convert the result to floating-point format.
Display the average with two decimal places.
Calculation Example

Input:

text
10, 20, 30, 40, 50


Calculation:

text
Sum = 10 + 20 + 30 + 40 + 50
Sum = 150

Average = 150 / 5
Average = 30.00

6. Assembly Instructions
Instruction	Description
MOV	Move data
CDQ	Sign-extend EAX into EDX:EAX
ADD	Add two operands
ADC	Add with carry
INC	Increment by one
CMP	Compare two operands
JL	Jump if less
FILD	Load integer into x87 FPU
FIDIV	Divide by an integer operand
FSTP	Store floating-point value and pop FPU stack
INVOKE	Call a procedure
RET	Return from procedure
7. Technical Implementation
7.1 64-bit Accumulation

The program uses a QWORD variable to store the sum of five signed 32-bit integers.

asm
sumValue QWORD 0


The following instructions perform signed 64-bit accumulation:

asm
mov eax, number
cdq
add DWORD PTR sumValue, eax
adc DWORD PTR sumValue+4, edx


This prevents overflow of the 32-bit sum when adding five large integers.

7.2 Average Calculation Using x87 FPU
asm
fild QWORD PTR sumValue
fidiv DWORD PTR five
fstp QWORD PTR average

FILD loads the 64-bit integer sum into the FPU.
FIDIV divides the sum by five.
FSTP stores the floating-point result in memory.
7.3 Output Formatting
asm
INVOKE printf, ADDR resultMsg, DWORD PTR average, DWORD PTR average+4


The printf function displays the calculated average using the %.2f format specifier.

8. Algorithm
text
START
  |
  v
Initialize sum = 0
Initialize count = 1
  |
  v
Input an integer
  |
  v
Validate input
  |
  +---- Invalid ----> Display error
  |                       |
  |                       v
  |                      END
  |
  v
Add integer to sum
  |
  v
Increment count
  |
  v
Are five integers entered?
  |
  +---- NO ----> Repeat input
  |
  YES
  |
  v
Calculate average = sum / 5
  |
  v
Display average
  |
  v
 END

9. Project Structure
text
MASM-Average/
│
├── main.asm
└── README.md

10. Build and Execution
Create a Win32 C++ Console project in Visual Studio.
Enable MASM build customization.
Add main.asm to the project.
Set the platform to Win32 (x86).
Set the ASM file item type to Microsoft Macro Assembler.
Build the project.
Run the executable.

The project uses the Microsoft C Runtime Library functions scanf_s and printf.

11. Conclusion

This project demonstrates basic arithmetic operations, loop control, input validation, and floating-point calculations using x86 Assembly Language.

It also demonstrates how to perform 64-bit signed integer accumulation using 32-bit registers and how to use the x87 FPU for floating-point division.

Through this implementation, the relationship between CPU registers, memory operations, arithmetic instructions, and runtime library functions can be examined in a practical MASM application.
