        NAME    main
        
        PUBLIC  __iar_program_start
        
        SECTION .intvec : CODE (2)
        THUMB
        
__iar_program_start
        B       main

        
        SECTION .text : CODE (2)
        THUMB

main
        NOP

        ADR R0, MATRIX1
        ADR R1, MATRIX2
        ADR R2, MATRIX3
        /*
        R0: MATRIX1의 주소를 저장해놓는 레지스터
        R1: MATRIX2의 주소를 저장해놓는 레지스터
        R2: MATRIX3의 주소를 저장해놓는 레지스터
        */
        
        MOV R8, #3
        MOV R9, #2
        MOV R10, #2
        MOV R5, #0
        /*
        R8: Loop1 영역이 실행되는 횟수
        R9: Store 영역이 실행되는 횟수
        R10: Loop2 영역이 실행되는 횟수
        R5: 두 행렬을 곱한 값의 element 하나를 저장하는 레지스터 
        */
        
Loop1   ; 두 행렬 내에서 element를 하나씩 불러옴으로써 행렬의 곱을 element 하나씩 진행하는 부분
        LDR R3, [R0], #4
        LDR R4, [R1], #8  ; R3, R4: 두 행렬 내에서 element를 하나씩 저장하는 레지스터
        MLA R5, R3, R4, R5  ; 행렬 내에서 두 값을 불러오고 서로 곱한 다음 더하기로 누적함
        SUBS R8, R8, #1
        BNE Loop1  ; 레지스터 R8의 값이 감소하다가 0이 되면 Loop1 영역을 빠져나오도록 설정
        
Store   ; 두 행렬을 곱한 결과 값을 element 하나씩 MATRIX3에 저장하고 다음 연산을 준비하는 부분 (1)
        STR R5, [R2], #4  ; 두 행렬을 곱한 결과 값을 element 하나씩 MATRIX3에 저장함
        SUB R0, R0, #12
        SUB R1, R1, #20  ; 다음 element의 결과값도 연산을 해야되므로 레지스터 R0, R1의 값을 다시 세팅함 (1)
        MOV R8, #3  ; Loop1 영역이 다시 실행되도록 하기 위해 레지스터 R8을 다시 3으로 세팅함
        MOV R5, #0  ; 다음 element를 계산하기 위해 0으로 세팅해줌
        SUBS R9, R9, #1
        BNE Loop1  ; 레지스터 R9의 값이 감소하다가 0이 되면 Store 영역을 빠져나오도록 설정
        
Loop2   ; 다음 연산을 준비하는 부분 (2)
        ADD R0, R0, #12
        SUB R1, R1, #8  ; 다음 element의 결과값도 연산을 해야되므로 레지스터 R0, R1의 값을 다시 세팅함 (2)
        MOV R9, #2  ; Store 영역이 다시 실행되도록 하기 위해 레지스터 R9을 다시 2로 세팅함
        
        SUBS R10, R10, #1
        BNE Loop1  ; 레지스터 R10의 값이 감소하다가 0이 되면 Loop2 영역을 빠져나오도록 설정

        DATA
MATRIX1 DCD 0x01, 0x02, 0x03, 0x04, 0x05, 0x06
MATRIX2 DCD 0x03, 0x00, 0x00, 0x02, 0x04, 0x01
MATRIX3

        END
