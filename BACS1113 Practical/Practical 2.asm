
INCLUDE Irvine32.inc

.data
TC DWORD 3200
TF DWORD ?
NUM1 DWORD 90
NUM2 DWORD 4

.code
main PROC
    mov eax, TC ; eax = TC
    mul NUM1    ; eax = eax * NUM1

    div NUM2    ; eax = eax / NUM2

    add eax, TC ; eax = eax + TC

    mov TF, eax ; TF = eax
    Call WriteHex

    exit
main ENDP
END main

; Practical 2B Q1

.data
myArray DWORD 70019, 9003, 3001, 4, 6, 1
count DWORD ($ - OFFSET myArray) / TYPE myArray ; Get the size of array, then divide by the type to get length
foundMsg BYTE "This is the first even number found: ", 0 
errorMsg BYTE "There is no even number in the array.", 0dh, 0ah, 0

.code
main PROC
    mov ecx, count
    mov esi, OFFSET myArray
    
    L1:
        mov eax, [esi]
        test eax, 1         ; Test if the least significant bit is 0 (even)
        jz found_even       ; Jump if zero (even number)
        add esi, 4          ; Move to next element
        LOOP L1
    
    ; Print a message if there is no even number
    mov edx, OFFSET errorMsg
    call WriteString
    jmp done
    
    found_even:
        mov edx, OFFSET foundMsg
        call WriteString
        call WriteInt
        call Crlf ; Carriage return with Irvine Library
    
    done:
        exit

; Practical 2B Q2

TITLE Print number array (.asm)
; This program prints all numbers in an array
; Last update: March 10, 2025
INCLUDE Irvine32.inc

.data
myArray DWORD 19900, 3000, 50000, 70000, 900
count DWORD ($ - OFFSET myArray) / TYPE myArray
foundMsg BYTE "These are the numbers in the array: ", 0 
errorMsg BYTE "There is no number in the array.", 0dh, 0ah, 0
arrayOutOfBoundMsg BYTE "The array is out of bound", 0dh, 0ah, 0

.code
main PROC
    ; Passing parameters via stack
    push OFFSET myArray    ; Push array address first
    push count             ; Push count second
    call PrintNumber       ; User-defined function
    exit
main ENDP

PrintNumber PROC
    push ebp               ; Save EBP
    mov ebp, esp           ; Get stack pointer
    pushad                 ; Save all registers
    
    mov ecx, [ebp+8]       ; Get count parameter
    mov esi, [ebp+12]      ; Get array pointer parameter
    
    ; Check if count is in valid range
    test ecx, ecx          ; Test if count is zero
    jle emptyArray         ; Jump if count <= 0
    cmp ecx, 10000         ; Optional: Check for unreasonably large value
    ja arrayOutOfBound     ; Jump if count > 10000 (sanity check)
    
    ; Continue if the array is not empty
    mov edx, OFFSET foundMsg
    call WriteString
    call Crlf
    
    PRINT:
        mov eax, [esi]     ; Get the current number
        call WriteInt      ; Print the number (uses EAX)
        mov al, ' '        ; Print a space between numbers
        call WriteChar
        add esi, 4         ; Move to next DWORD
        loop PRINT
        
    call Crlf              ; Add newline at the end
    jmp done
    
emptyArray:
    mov edx, OFFSET errorMsg
    call WriteString

arrayOutOfBound:
    mov edx, OFFSET arrayOutOfBoundMsg
    call WriteString
    
done:
    popad                  ; Restore all registers
    pop ebp                ; Restore EBP
    ret 8                  ; Clean up 8 bytes of parameters
PrintNumber ENDP

; Practical 2B Q3

INCLUDE Irvine32.inc

.data
Rval DWORD ?
Xval DWORD 2600
Yval DWORD 3000
Zval DWORD 4000

.code
main PROC
    mov ebx, Yval
    sub ebx, Zval
    sub ebx, Xval
    mov Rval, ebx

    mov eax, Rval
    Call WriteHex

    exit
main ENDP
END main

; Practical 2B Q4

INCLUDE Irvine32.inc

.data
TC DWORD 3200
TF DWORD ?
NUM1 DWORD 90
NUM2 DWORD 4

.code
main PROC
    mov eax, TC ; eax = TC
    mul NUM1    ; eax = eax * NUM1

    div NUM2    ; eax = eax / NUM2

    add eax, TC ; eax = eax + TC

    mov TF, eax ; TF = eax
    Call WriteHex

    exit
main ENDP
END main