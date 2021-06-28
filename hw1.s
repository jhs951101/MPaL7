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
        R0: MATRIX1�� �ּҸ� �����س��� ��������
        R1: MATRIX2�� �ּҸ� �����س��� ��������
        R2: MATRIX3�� �ּҸ� �����س��� ��������
        */
        
        MOV R8, #3
        MOV R9, #2
        MOV R10, #2
        MOV R5, #0
        /*
        R8: Loop1 ������ ����Ǵ� Ƚ��
        R9: Store ������ ����Ǵ� Ƚ��
        R10: Loop2 ������ ����Ǵ� Ƚ��
        R5: �� ����� ���� ���� element �ϳ��� �����ϴ� �������� 
        */
        
Loop1   ; �� ��� ������ element�� �ϳ��� �ҷ������ν� ����� ���� element �ϳ��� �����ϴ� �κ�
        LDR R3, [R0], #4
        LDR R4, [R1], #8  ; R3, R4: �� ��� ������ element�� �ϳ��� �����ϴ� ��������
        MLA R5, R3, R4, R5  ; ��� ������ �� ���� �ҷ����� ���� ���� ���� ���ϱ�� ������
        SUBS R8, R8, #1
        BNE Loop1  ; �������� R8�� ���� �����ϴٰ� 0�� �Ǹ� Loop1 ������ ������������ ����
        
Store   ; �� ����� ���� ��� ���� element �ϳ��� MATRIX3�� �����ϰ� ���� ������ �غ��ϴ� �κ� (1)
        STR R5, [R2], #4  ; �� ����� ���� ��� ���� element �ϳ��� MATRIX3�� ������
        SUB R0, R0, #12
        SUB R1, R1, #20  ; ���� element�� ������� ������ �ؾߵǹǷ� �������� R0, R1�� ���� �ٽ� ������ (1)
        MOV R8, #3  ; Loop1 ������ �ٽ� ����ǵ��� �ϱ� ���� �������� R8�� �ٽ� 3���� ������
        MOV R5, #0  ; ���� element�� ����ϱ� ���� 0���� ��������
        SUBS R9, R9, #1
        BNE Loop1  ; �������� R9�� ���� �����ϴٰ� 0�� �Ǹ� Store ������ ������������ ����
        
Loop2   ; ���� ������ �غ��ϴ� �κ� (2)
        ADD R0, R0, #12
        SUB R1, R1, #8  ; ���� element�� ������� ������ �ؾߵǹǷ� �������� R0, R1�� ���� �ٽ� ������ (2)
        MOV R9, #2  ; Store ������ �ٽ� ����ǵ��� �ϱ� ���� �������� R9�� �ٽ� 2�� ������
        
        SUBS R10, R10, #1
        BNE Loop1  ; �������� R10�� ���� �����ϴٰ� 0�� �Ǹ� Loop2 ������ ������������ ����

        DATA
MATRIX1 DCD 0x01, 0x02, 0x03, 0x04, 0x05, 0x06
MATRIX2 DCD 0x03, 0x00, 0x00, 0x02, 0x04, 0x01
MATRIX3

        END
