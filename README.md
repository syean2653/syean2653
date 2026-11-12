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
Assembly Language - Average of Five Numbers
1. 프로젝트 소개 (Project Overview)

이 프로젝트는 Assembly Language를 사용하여 사용자로부터 정수 5개를 입력받고, 입력받은 숫자의 평균을 계산하여 출력하는 프로그램입니다.

Microsoft Visual Studio와 MASM(Microsoft Macro Assembler)을 사용하여 구현하였습니다.

2. 개발 환경 (Development Environment)
IDE: Microsoft Visual Studio
Language: Assembly Language
Assembler: MASM
Platform: x64
Runtime Library: C Runtime Library
3. 프로그램 기능 (Program Features)
사용자로부터 정수 5개를 입력받습니다.
입력받은 숫자 5개의 합계를 계산합니다.
합계를 5로 나누어 평균을 계산합니다.
계산된 평균을 소수점 둘째 자리까지 출력합니다.
4. 실행 결과 (Execution Result)
입력 예시
text
Enter 5 integers:
Number 1: 10
Number 2: 20
Number 3: 30
Number 4: 40
Number 5: 50

출력 결과
text
Average = 30.00

다른 실행 예시
text
Enter 5 integers:
Number 1: 5
Number 2: 10
Number 3: 15
Number 4: 20
Number 5: 25

Average = 15.00

5. 평균 계산 과정 (Calculation Process)

첫 번째 실행 예시를 기준으로 계산하면 다음과 같습니다.

입력값: 10, 20, 30, 40, 50
합계: 10 + 20 + 30 + 40 + 50 = 150
평균: 150 / 5 = 30

따라서 최종 출력값은 다음과 같습니다.

Average = 30.00

6. 사용한 어셈블리 명령어 (Assembly Instructions)
명령어	기능
MOV	데이터 이동
ADD	두 값 더하기
INC	값 1 증가
CMP	두 값 비교
JL	작을 경우 점프
CVTSI2SD	정수를 실수로 변환
DIVSD	실수 나눗셈
CALL	함수 호출
RET	함수 종료 및 복귀
7. 알고리즘 (Algorithm)
합계를 저장할 변수를 0으로 초기화합니다.
반복 횟수를 1로 설정합니다.
사용자로부터 정수 하나를 입력받습니다.
입력받은 숫자를 합계에 더합니다.
반복 횟수를 1 증가시킵니다.
숫자 5개를 입력받을 때까지 반복합니다.
최종 합계를 5로 나눕니다.
계산된 평균을 출력합니다.
8. 프로젝트 파일 구조 (Project Structure)
text
Assembly-Average/
│
├── main.asm
└── README.md

9. 실행 방법 (How to Run)
Microsoft Visual Studio를 실행합니다.
C++ 콘솔 프로젝트를 생성합니다.
MASM 빌드 지원을 활성화합니다.
main.asm 파일을 프로젝트에 추가합니다.
플랫폼을 x64로 설정합니다.
프로젝트를 빌드하고 실행합니다.
정수 5개를 입력하고 평균 결과를 확인합니다.
10. 결론 (Conclusion)

이번 프로젝트를 통해 Assembly Language의 기본적인 데이터 처리와 산술 연산을 학습하였습니다.

특히 MOV, ADD, CMP, JL 등의 명령어를 활용하여 데이터를 처리하고 반복문을 구현하였으며, 입력받은 다섯 숫자의 평균을 계산하는 과정을 이해할 수 있었습니다.
