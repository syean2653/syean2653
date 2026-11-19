; 두 개의 숫자를 입력받아 사칙연산 결과와
; EAX, EBX, ECX, EDX 레지스터의 내용을 출력하는 프로그램
; (Irvine32 라이브러리 사용)

INCLUDE Irvine32.inc

.data
numA SDWORD ?
numB SDWORD ?

.code
main PROC
    ; ---- 입력 ----
    mWrite "Enter first number  : "
    call ReadInt
    mov  numA, eax

    mWrite "Enter second number : "
    call ReadInt
    mov  numB, eax
    call Crlf

    ; ---- 덧셈 ----
    mWrite "[ADD] A + B = "
    mov  eax, numA
    add  eax, numB
    call WriteInt
    call Crlf
    call DumpRegs

    ; ---- 뺄셈 ----
    mWrite "[SUB] A - B = "
    mov  eax, numA
    sub  eax, numB
    call WriteInt
    call Crlf
    call DumpRegs

    ; ---- 곱셈 ----
    mWrite "[MUL] A * B = "
    mov  eax, numA
    imul numB                ; EDX:EAX = EAX * numB
    call WriteInt            ; 하위 32비트(EAX) 출력
    call Crlf
    call DumpRegs

    ; ---- 나눗셈 ----
    cmp  numB, 0
    je   DivZero
    mWrite "[DIV] A / B = "
    mov  eax, numA
    cdq                      ; EDX:EAX 부호 확장
    idiv numB                ; 몫 EAX, 나머지 EDX
    call WriteInt            ; 몫 출력
    mWrite "  remainder = "
    push eax
    mov  eax, edx
    call WriteInt            ; 나머지 출력
    pop  eax
    call Crlf
    call DumpRegs
    jmp  Done

DivZero:
    mWrite "[DIV] Error: division by zero"
    call Crlf

Done:
    exit
main ENDP
END main
