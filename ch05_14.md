# Chapter 5 — Review Questions and Exercises (5.8.1 Short Answer)

---

## 1. 32비트 범용 레지스터를 모두 스택에 push하는 명령어는?

**답: `PUSHAD`**

EAX, ECX, EDX, EBX, ESP(실행 전 값), EBP, ESI, EDI 순서로 8개의 32비트 레지스터를 스택에 push한다.

---

## 2. 32비트 EFLAGS 레지스터를 스택에 push하는 명령어는?

**답: `PUSHFD`**

---

## 3. 스택에서 pop하여 EFLAGS 레지스터에 넣는 명령어는?

**답: `POPFD`**

---

## 4. (Challenge) NASM의 `PUSH EAX EBX ECX` 방식이 MASM의 PUSHAD보다 나은 이유는?

**답:**

- **효율성:** PUSHAD는 실제로 필요한지와 상관없이 레지스터 8개(32바이트)를 전부 push한다. NASM 방식은 프로시저 안에서 실제로 수정되는 레지스터만 골라 저장하므로 스택 공간과 실행 시간이 절약된다.
- **반환값 보존:** PUSHAD/POPAD는 EAX까지 저장·복원하기 때문에, EAX로 결과를 반환하는 프로시저에서 POPAD를 쓰면 반환값이 원래 값으로 덮어써진다. 레지스터를 선택적으로 push하면 반환용 레지스터는 빼고 저장할 수 있다.

---

## 5. (Challenge) PUSH 명령어가 없다고 가정하고, `push eax`와 같은 동작을 하는 두 명령어를 작성하라.

**답:**

```asm
sub  esp, 4        ; 스택 포인터를 4바이트 감소
mov  [esp], eax    ; 새 스택 top 위치에 EAX 저장
```

PUSH는 "ESP를 피연산자 크기만큼 감소시킨 뒤, ESP가 가리키는 주소에 값을 저장"하는 동작이므로 위 두 줄과 동일하다.

---

## 6. (T/F) RET 명령어는 스택 top의 값을 instruction pointer로 pop한다.

**답: True**

RET는 CALL이 저장해 둔 복귀 주소를 스택에서 꺼내 EIP에 넣는다.

---

## 7. (T/F) MASM에서는 프로시저 정의에 NESTED 연산자를 쓰지 않으면 중첩 프로시저 호출이 허용되지 않는다.

**답: False**

MASM은 별도의 연산자 없이 중첩 호출을 허용한다. NESTED라는 연산자는 존재하지 않는다.

---

## 8. (T/F) 보호 모드에서 각 프로시저 호출은 최소 4바이트의 스택 공간을 사용한다.

**답: True**

CALL은 32비트(4바이트) 복귀 주소를 스택에 push하므로 최소 4바이트를 사용한다.

---

## 9. (T/F) ESI와 EDI 레지스터는 프로시저에 32비트 인자를 전달할 때 사용할 수 없다.

**답: False**

ESI, EDI도 다른 범용 레지스터처럼 인자 전달에 사용할 수 있다. 실제로 ArraySum 프로시저는 ESI로 배열 주소를 전달받는다.

---

## 10. (T/F) ArraySum 프로시저(5.2.5절)는 임의의 doubleword 배열에 대한 포인터를 받는다.

**답: True**

ArraySum은 ESI에 배열의 오프셋, ECX에 원소 개수를 받으므로 특정 배열에 종속되지 않고 어떤 DWORD 배열이든 처리할 수 있다.

---

## 11. (T/F) USES 연산자로 프로시저 안에서 수정되는 모든 레지스터를 지정할 수 있다.

**답: True**

`PROC USES` 뒤에 프로시저에서 수정하는 레지스터를 나열하면, 어셈블러가 이를 저장·복원하는 코드를 자동으로 생성한다.

---

## 12. (T/F) USES 연산자는 PUSH 명령어만 생성하므로 POP 명령어는 직접 작성해야 한다.

**답: False**

USES는 프로시저 시작 부분에 PUSH를, 각 RET 직전에 POP(역순)을 모두 자동 생성한다.

---

## 13. (T/F) USES 지시어의 레지스터 목록은 쉼표로 구분해야 한다.

**답: False**

레지스터 이름은 공백으로 구분한다. 쉼표를 쓰면 어셈블 오류가 난다.

```asm
ArraySum PROC USES esi ecx     ; 올바른 형식
```

---

## 14. ArraySum이 16비트 WORD 배열의 합을 구하도록 하려면 어떤 문장을 수정해야 하는가? 수정 버전을 만들고 테스트하라.

**답: 다음 두 문장을 수정한다.**

| 원래 코드 | 수정 코드 | 이유 |
|---|---|---|
| `add eax,[esi]` | `add ax,[esi]` | 메모리에서 4바이트가 아니라 2바이트(WORD)씩 읽어 더해야 함 |
| `add esi,TYPE DWORD` | `add esi,TYPE WORD` | 다음 원소로 이동할 때 포인터를 4가 아니라 2씩 증가시켜야 함 |

`mov eax,0`은 그대로 두면 된다. EAX 전체를 0으로 만들어 두면 AX에 합이 쌓여도 EAX 상위 16비트가 0이므로, 결과를 EAX 그대로 출력할 수 있다.

**수정된 프로시저 및 테스트 프로그램** (`ArraySum16.asm`):

```asm
; ArraySum16.asm
; Chapter 5 Review Question 14
; 16비트 WORD 배열의 합을 구하도록 수정한 ArraySum

INCLUDE Irvine32.inc

.data
array WORD 1000, 2000, 3000, 4000, 5000

.code
main PROC
    mov  esi, OFFSET array      ; ESI = 배열 주소
    mov  ecx, LENGTHOF array    ; ECX = 원소 개수
    call ArraySum               ; AX = 배열의 합
    call WriteDec               ; EAX를 10진수로 출력 (15000)
    call Crlf
    exit
main ENDP

;-----------------------------------------------------
ArraySum PROC
;
; 16비트 정수 배열의 합을 계산한다.
; Receives: ESI = 배열의 오프셋
;           ECX = 배열 원소 개수
; Returns:  AX  = 배열 원소의 합 (EAX 상위 16비트는 0)
;-----------------------------------------------------
    push esi                    ; ESI, ECX 저장
    push ecx
    mov  eax, 0                 ; 합을 0으로 초기화
L1:
    add  ax, [esi]              ; [수정] eax → ax : WORD 단위로 더함
    add  esi, TYPE WORD         ; [수정] TYPE DWORD → TYPE WORD : 2바이트씩 이동
    loop L1                     ; 배열 크기만큼 반복
    pop  ecx                    ; ECX, ESI 복원
    pop  esi
    ret                         ; 합은 AX에 있음
ArraySum ENDP

END main
```

**예상 실행 결과:**

```
15000
```

(1000 + 2000 + 3000 + 4000 + 5000 = 15000)

> 참고: 합이 16비트 범위(65535)를 넘을 수 있다면 AX에서 오버플로가 난다. 그런 경우 `movzx edx, WORD PTR [esi]` 후 `add eax, edx`처럼 32비트로 확장해서 더하면 된다 (EDX도 push/pop으로 보존).

---

## 15. 다음 명령어 실행 후 EAX의 최종 값은?

```asm
push 5
push 6
pop  eax
pop  eax
```

**답: EAX = 5**

| 명령어 | 스택 (top은 오른쪽) | EAX |
|---|---|---|
| `push 5` | 5 | - |
| `push 6` | 5, 6 | - |
| `pop eax` | 5 | 6 |
| `pop eax` | (비어 있음) | **5** |

스택은 LIFO이므로 나중에 push한 6이 먼저 나오고, 마지막 pop에서 5가 EAX에 들어간다.

---

## 16. 예제 코드 실행 시 올바른 설명은? (Ex2Sub)

**답: d. The program will halt with a runtime error on Line 11**

| 줄 | 명령어 | 스택 (top은 오른쪽) | 설명 |
|---|---|---|---|
| 2 | `push 10` | 10 | |
| 3 | `push 20` | 10, 20 | |
| 4 | `call Ex2Sub` | 10, 20, 복귀주소 | 복귀 주소(5번 줄) push |
| 10 | `pop eax` | 10, 20 | EAX = 복귀 주소. 복귀 주소가 스택에서 사라짐 |
| 11 | `ret` | 10 | 스택 top인 **20**을 EIP로 pop → 주소 20으로 점프 |

`ret`가 복귀 주소 대신 20을 EIP에 넣기 때문에 유효하지 않은 주소로 제어가 넘어가고, 11번 줄에서 런타임 오류(access violation)가 발생한다.

---

## 17. 예제 코드 실행 시 올바른 설명은? (Ex3Sub)

**답: c. EAX will equal 30 on line 6**

| 줄 | 명령어 | 설명 |
|---|---|---|
| 2 | `mov eax,30` | EAX = 30 |
| 3~4 | `push eax` / `push 40` | 스택: 30, 40 |
| 5 | `call Ex3Sub` | 복귀 주소 push |
| 10 | `pusha` | 16비트 레지스터 8개(AX, CX, DX, BX, SP, BP, SI, DI) push → AX = 30 저장 |
| 11 | `mov eax,80` | EAX = 80 |
| 12 | `popa` | 저장했던 값 복원 → AX = 30. EAX 상위 16비트는 80일 때도 0이었으므로 EAX = 30 |
| 13 | `ret` | pusha/popa로 스택이 균형을 이루므로 정상적으로 6번 줄로 복귀 |

따라서 6번 줄에서 EAX = 30이다. (main에서 push한 30, 40은 스택에 남아 있지만 ExitProcess 호출에는 영향이 없다.)

---

## 18. 예제 코드 실행 시 올바른 설명은? (Ex4Sub)

**답: a. EAX will equal 30 on line 7**

| 줄 | 명령어 | 설명 |
|---|---|---|
| 2 | `mov eax,40` | EAX = 40 |
| 3 | `push offset Here` | `Here` 레이블의 주소를 스택에 push |
| 4 | `jmp Ex4Sub` | CALL이 아닌 JMP이므로 복귀 주소는 push되지 않음 |
| 11 | `ret` | 스택 top인 `Here`의 주소를 EIP로 pop → `Here`로 이동 |
| 6 | `mov eax,30` | EAX = 30 |
| 7 | `INVOKE ExitProcess,0` | 이 시점에 EAX = 30 |

`push offset Here` + `jmp`가 `call`과 같은 효과를 내므로 `ret`는 정상 동작한다. 6번 줄에 도달한 시점에는 아직 EAX = 40이므로 c는 틀리고, 6번 줄을 실행한 뒤인 7번 줄에서 EAX = 30이다.

---

## 19. 예제 코드 실행 시 올바른 설명은? (Ex5Sub)

**답: a. EDX will equal 40 on line 6**

| 줄 | 명령어 | 스택 (top은 오른쪽) | 레지스터 |
|---|---|---|---|
| 2 | `mov edx,0` | | EDX = 0 |
| 3 | `mov eax,40` | | EAX = 40 |
| 4 | `push eax` | 40 | |
| 5 | `call Ex5Sub` | 40, 복귀주소 | |
| 10 | `pop eax` | 40 | EAX = 복귀주소 |
| 11 | `pop edx` | (비어 있음) | **EDX = 40** |
| 12 | `push eax` | 복귀주소 | |
| 13 | `ret` | (비어 있음) | 6번 줄로 정상 복귀 |

복귀 주소를 잠시 EAX에 꺼내 두었다가 다시 push하므로 `ret`는 정상적으로 6번 줄로 돌아간다. 그 사이 스택 인자 40이 EDX로 들어간다.

---

## 20. 다음 코드 실행 후 array에 기록되는 값은?

**답: array = 10, 20, 30, 40**

호출 순서는 `main → proc_1 → proc_2 → proc_3`이고, 실제로 배열에 쓰는 순서는 가장 깊은 프로시저부터 거꾸로 돌아오면서 진행된다.

| 실행 위치 | ESI | EAX | 기록 |
|---|---|---|---|
| main 시작 | 0 | 10 | |
| proc_3 | 0 | 10 | array[0] = **10** |
| proc_2 (proc_3에서 복귀 후) | 4 | 20 | array[4] = **20** |
| proc_1 (proc_2에서 복귀 후) | 8 | 30 | array[8] = **30** |
| main (proc_1에서 복귀 후) | 12 | 40 | array[12] = **40** |

배열이 DWORD(4바이트)이므로 ESI가 0, 4, 8, 12로 증가하면서 array의 첫 번째부터 네 번째 원소까지 차례로 채워진다.
