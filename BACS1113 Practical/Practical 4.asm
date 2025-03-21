TITLE Practical 4 Q4 (.asm)
INCLUDE Irvine32.inc

.data
studentScoreArray BYTE 50, 67, 82, 42, 80, 77, 65
studentScoreArraySize DWORD ($ - OFFSET studentScoreArray) / TYPE studentScoreArray
ALIGN DWORD
studentGradeArray BYTE LENGTHOF studentScoreArray DUP(?)

.code
main PROC
    
    mov esi, 0
    mov edi, 0
    mov ecx, studentScoreArraySize

    GetGrade:
        mov al, studentScoreArray[esi * TYPE studentScoreArray]
        call ReturnGrade ; User-defined function
        inc esi
        LOOP GetGrade

    mov ecx, studentScoreArraySize

    mov esi, 0
    
    PrintGrade:
        mov al, studentGradeArray[esi * TYPE studentGradeArray]
        call WriteChar
        inc esi

        ; Skip "," for the last element
        dec ecx
        jz done

        mov al, ","
        call WriteChar
        mov al, " "
        call WriteChar
        jmp PrintGrade

    done:
        call Crlf
    exit
main ENDP

;-----------------------------------------------------------------------
; ReturnGrade - Stores the grade based on the marks in studentGradeArray
; Receives: one student mark value in AL register
; Returns:  student grade
;-----------------------------------------------------------------------
ReturnGrade PROC
    cmp al, 80d
    jae GradeA

    cmp al, 70d
    jae GradeB

    cmp al, 60d
    jae GradeC

    cmp al, 50d
    jae GradeD
    
    GradeE:
        mov al, 'E'
        jmp done

    GradeA:
        mov al, 'A'
        jmp done

    GradeB:
        mov al, 'B'
        jmp done

    GradeC:
        mov al, 'C'
        jmp done

    GradeD:
        mov al, 'D'

    done:
        mov studentGradeArray[edi * TYPE studentGradeArray], al
        inc edi
        ret

ReturnGrade ENDP
END main

TITLE Practical 4 Q1 (.asm)
; This program counts the number of positive and negative values
; in a predefined list of WORD-sized integers

INCLUDE Irvine32.inc

.data
list WORD 1200, -209, -900, 501, -480, 200, 240, 0
listSize DWORD ($ - list) / TYPE list   ; Calculate number of elements
positiveCount DWORD 0                   ; Counter for positive values
negativeCount DWORD 0                   ; Counter for negative values
zeroCount DWORD 0                       ; Counter for zero values

msgPositive BYTE "Number of positive values: ", 0
msgNegative BYTE "Number of negative values: ", 0
msgZero BYTE "Number of zero values: ", 0

.code
main PROC
    ; Initialize pointer to the list
    mov esi, OFFSET list
    mov ecx, listSize                   ; Loop counter

countLoop:
    movsx eax, WORD PTR [esi]           ; Load value with sign extension
    cmp eax, 0                          ; Compare with zero
    je isZero                           ; Jump if equal to zero
    jg isPositive                       ; Jump if greater than zero
    
    ; If we reach here, the value is negative
    inc negativeCount
    jmp nextIteration
    
isPositive:
    inc positiveCount
    jmp nextIteration
    
isZero:
    inc zeroCount
    
nextIteration:
    add esi, TYPE list                  ; Move to next element
    LOOP countLoop                      ; Decrement ECX and loop if not zero
    
    ; Display results
    mov edx, OFFSET msgPositive
    call WriteString
    mov eax, positiveCount
    call WriteDec
    call Crlf
    
    mov edx, OFFSET msgNegative
    call WriteString
    mov eax, negativeCount
    call WriteDec
    call Crlf
    
    mov edx, OFFSET msgZero
    call WriteString
    mov eax, zeroCount
    call WriteDec
    call Crlf
    
    exit
main ENDP
END main

TITLE Practical 4 Q2 (.asm)

INCLUDE Irvine32.inc

.data
promptMsg BYTE "Do you want to continue printing (y/n) ? ", 0

.code
main PROC

    mov bl, 41h

    print_alphabet:
        mov al, bl
        call WriteChar

        call Crlf
        lea edx, promptMsg
        call WriteString

        call ReadChar
        cmp al, "Y"
        je continue
        cmp al, "y"
        je continue
        jmp done

    continue:
        inc bl
        call Crlf
        jmp print_alphabet

    done:
        call Crlf

    exit
main ENDP
END main

TITLE Practical 4 Q3 (.asm)
INCLUDE Irvine32.inc

.data
promptMsg BYTE "Enter your text: ", 0
englishHeader BYTE "In english: ", 0
eggnglishHeader BYTE "In eggnglish: ", 0
bufferSize = 255
englishText BYTE bufferSize DUP(0)
eggnglishText BYTE bufferSize*2 DUP(0) ; Probably need more buffer size for eggnglish

.code
main PROC
    ; Prompt for input
    lea edx, promptMsg
    call WriteString
    
    ; Read English text
    lea edx, englishText
    mov ecx, bufferSize
    call ReadString
    mov ebx, eax                ; Save the length of input string in ebx
    
    ; Display English text
    call Crlf
    mov edx, OFFSET englishHeader
    call WriteString
    mov edx, OFFSET englishText
    call WriteString
    call Crlf
    
    ; Convert to Eggnglish
    call ConvertToEggnglish ; User-defined function
    
    ; Display Eggnglish text
    mov edx, OFFSET eggnglishHeader
    call WriteString
    mov edx, OFFSET eggnglishText
    call WriteString
    
    call Crlf
    exit
main ENDP

;------------------------------------------------------------
; ConvertToEggnglish - Converts English to Eggnglish
; Receives: englishText contains source string, ebx = length
; Returns:  eggnglishText contains converted string
;------------------------------------------------------------
ConvertToEggnglish PROC
    mov esi, 0                  ; Source index (English)
    mov edi, 0                  ; Destination index (Eggnglish)
    
    cmp ebx, 0                  ; Check if string is empty
    je done
    
convert_loop:
    mov al, BYTE PTR [englishText+esi]    ; Get current character, direct indexing with register
    
    ; Check if character is a "e" or "E"
    cmp al, 'e'
    je e_found
    
    cmp al, 'E'
    je e_found
    
    ; Not an 'e', just copy the character
    mov BYTE PTR [eggnglishText+edi], al
    inc edi
    jmp next_char
    
e_found:
    ; Change "e" to "egg"
    mov BYTE PTR [eggnglishText+edi], 'e'
    inc edi
    mov BYTE PTR [eggnglishText+edi], 'g'
    inc edi
    mov BYTE PTR [eggnglishText+edi], 'g'
    inc edi
    
next_char:
    inc esi                     ; Move to next character in source
    dec ebx                     ; Decrement counter
    jnz convert_loop            ; Continue if not zero
    
    ; Null-terminate the Eggnglish string
    mov BYTE PTR [eggnglishText+edi], 0
    
done:
    ret
ConvertToEggnglish ENDP

END main

TITLE Practical 4 Q4 (.asm)
INCLUDE Irvine32.inc

.data
studentScoreArray BYTE 50, 67, 82, 42, 80, 77, 65
studentScoreArraySize DWORD ($ - OFFSET studentScoreArray) / TYPE studentScoreArray
ALIGN DWORD; Align for optimal performance of CPU
studentGradeArray BYTE LENGTHOF studentScoreArray DUP(?)

.code
main PROC
    
    mov esi, 0
    mov edi, 0
    mov ecx, studentScoreArraySize

    GetGrade:
        mov al, studentScoreArray[esi * TYPE studentScoreArray]
        call ReturnGrade ; User-defined function
        inc esi
        LOOP GetGrade

    mov ecx, studentScoreArraySize

    mov esi, 0
    
    PrintGrade:
        mov al, studentGradeArray[esi * TYPE studentGradeArray]
        call WriteChar
        inc esi

        ; Skip "," for the last element
        dec ecx
        jz done

        mov al, ","
        call WriteChar
        mov al, " "
        call WriteChar
        jmp PrintGrade

    done:

    exit
main ENDP

;-----------------------------------------------------------------------
; ReturnGrade - Stores the grade based on the marks in studentGradeArray
; Receives: one student mark value in AL register
; Returns:  student grade
;-----------------------------------------------------------------------
ReturnGrade PROC
    cmp al, 80d
    jae GradeA

    cmp al, 70d
    jae GradeB

    cmp al, 60d
    jae GradeC

    cmp al, 50d
    jae GradeD
    
    GradeE:
        mov al, 'E'
        jmp done

    GradeA:
        mov al, 'A'
        jmp done

    GradeB:
        mov al, 'B'
        jmp done

    GradeC:
        mov al, 'C'
        jmp done

    GradeD:
        mov al, 'D'

    done:
        mov studentGradeArray[edi * TYPE studentGradeArray], al
        inc edi
        ret

ReturnGrade ENDP
END main