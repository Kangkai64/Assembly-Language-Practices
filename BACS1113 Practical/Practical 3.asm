TITLE  Practical 3 Q5    (.asm)
; This program 
; Last update:
INCLUDE Irvine32.inc

.data
fibNumArray DWORD 30 DUP(?)
count DWORD ($ - OFFSET fibNumArray) / TYPE fibNumArray

.code
main PROC
    
    lea esi, fibNumArray

    ; Initialize first 2 elements
    mov eax, 1
    ; Direct indexing
    mov fibNumArray[0], eax 
    mov fibNumArray[TYPE fibNumArray], eax

    lea esi, fibNumArray
    mov ecx, count
    sub ecx, 2      ; Only fill 28 numbers

    fill_fibNumArray:
        mov eax, [esi]
        add eax, [esi + TYPE fibNumArray]
        mov [esi + 2 * TYPE fibNumArray], eax
        add esi, TYPE fibNumArray
        LOOP fill_fibNumArray

    lea esi, fibNumArray
    mov ecx, count

    print_array:
        mov eax, [esi]
        call WriteDec

        ; Skip "," for the last element
        dec ecx
        jz done

        mov al, ","
        call WriteChar
        mov al, " "
        call WriteChar

        add esi, TYPE fibNumArray ; Move to the next element

        jmp print_array
    
done:
    call Crlf
    exit
main ENDP
END main

TITLE  Practical 3 Q1    (.asm)

; This program
; Last update:

INCLUDE Irvine32.inc

.data
data1 BYTE "MILK", 0
size1 BYTE ($ - OFFSET data1) - 1
data2 BYTE 4 DUP("*"), 0
size2 BYTE ($ - OFFSET data2) - 1
errorMsg BYTE "The destination's size is smaller than the source's size.", 0

.code
main PROC

	; Check if the destination size is enough
	mov bl, size2
	cmp bl, size1
	jb sizeIsTooSmall

	LEA esi, data1
	LEA edi, data2

	mov ecx, 0
	mov cl, size1
	
	L1:
		mov al, [esi]
		mov [edi], al
		inc esi
		inc edi

		LOOP L1

	LEA esi, data2

	; Check if the value is passed correctly
	mov edx, esi
	Call WriteString
	jmp done

	sizeIsTooSmall:
		LEA edx, errorMsg
		Call WriteString

	done:
	
	Call Crlf
	exit
main ENDP
END main

; Practical 3 Q2
TITLE      (.asm)

; This program
; Last update:

INCLUDE Irvine32.inc

.data
data1 BYTE "MILK", 0
size1 BYTE $ - OFFSET data1 - 1  ; Don't count the null terminator in the size, can use LENGTHOF
data2 BYTE 4 DUP("*"), 0
size2 BYTE $ - OFFSET data2 - 1  ; Don't count the null terminator in the size, can use LENGTHOF
errorMsg BYTE "The destination's size is smaller than the source's size.", 0

.code
main PROC
    ; Check if the destination size is enough
    mov bl, size2
    cmp bl, size1
    jb sizeIsTooSmall
    
    LEA esi, data1        ; Start of source string
    ADD esi, SIZEOF data1 - 2  ; Point to last character before null terminator
    LEA edi, data2        ; Start of destination string
    mov ecx, 0
    mov cl, size1
    
    L1:
        mov al, [esi]
        mov [edi], al
        dec esi
        inc edi
        LOOP L1
    
    ; Ensure null termination
    mov BYTE PTR [edi], 0
    
    ; Display the string
    LEA edx, data2
    Call WriteString
    jmp done
    
    sizeIsTooSmall:
        LEA edx, errorMsg
        Call WriteString
    done:
    
    Call Crlf
    exit
main ENDP
END main

TITLE  Practical 3 Q3    (.asm)
; This program sorts an array using bubble sort and displays the result
; Last update:
INCLUDE Irvine32.inc

.data
data1 DWORD 60000, 80000, 92100, 100000, 2000
size1 DWORD ($ - OFFSET data1) / TYPE data1
data2 DWORD 5 DUP(?)
size2 DWORD ($ - OFFSET data2) / TYPE data2
errorMsg BYTE "The destination's size is smaller than the source's size.", 0

.code
main PROC
    ; Check if the destination size is enough
    mov ebx, size2
    cmp ebx, size1
    jb sizeIsTooSmall
    
    ; Bubble sort
    LEA esi, data1
    mov ecx, size1
    dec ecx                          ; Outer loop runs (n-1) times
    
outerLoop:
    push ecx                         ; Save outer loop counter
    LEA esi, data1                   ; Reset pointer to start of array
    mov ebx, ecx                     ; Inner loop counter = outer loop counter
    
innerLoop:
    mov eax, [esi]                  ; Get current element
    cmp eax, [esi + TYPE data1]     ; Compare with next element
    ja noSwap                       ; If current >= next, no swap needed
    
    ; Swap elements
    xchg eax, [esi + TYPE data1]     ; Get next element
    xchg [esi], eax                  ; Store next element in current position
    
noSwap:
    add esi, TYPE data1              ; Move to next element
    dec ebx                          ; Decrement inner loop counter
    jnz innerLoop                    ; Continue inner loop if not done
    
    pop ecx                          ; Restore outer loop counter
    LOOP outerLoop                   ; Continue outer loop if not done
    
    ; Copy sorted data to data2
    LEA esi, data1
    LEA edi, data2
    mov ecx, size1
    
copyLoop:
    mov eax, [esi]
    mov [edi], eax
    add esi, TYPE data1
    add edi, TYPE data2
    loop copyLoop
    
    ; Print the sorted array
    LEA esi, data2
    mov ecx, size2
    
printLoop:
    mov eax, [esi]
    call WriteInt
    
    ; Add a comma except after the last element
    dec ecx
    jz done
    
    ; Print comma and space
    mov al, ','
    call WriteChar
    mov al, ' '
    call WriteChar
    
    add esi, TYPE data2
    jmp printLoop
    
sizeIsTooSmall:
    LEA edx, errorMsg
    call WriteString
    
done:
    call Crlf
    exit
main ENDP
END main

TITLE  Practical 3 Q4    (.asm)
; This program
; Last update:
INCLUDE Irvine32.inc

.data
dlist DWORD 2, 5000, 6000, 150000, 2500, 150
count DWORD ($ - OFFSET dlist) / TYPE dlist

.code
main PROC
    
    lea esi, dlist
    mov eax, 0
    mov ecx, count

    L1:
        add eax, [esi]
        add esi, TYPE dlist
        LOOP L1

    call WriteInt
    
done:
    call Crlf
    exit
main ENDP
END main

TITLE  Practical 3 Q5    (.asm)
; This program 
; Last update:
INCLUDE Irvine32.inc

.data
fibNumArray DWORD 30 DUP(?)
count DWORD ($ - OFFSET fibNumArray) / TYPE fibNumArray

.code
main PROC
    
    lea esi, fibNumArray

    ; Initialize first 2 elements
    mov eax, 1
    ; Direct indexing
    mov fibNumArray[0], eax 
    mov fibNumArray[TYPE fibNumArray], eax

    lea esi, fibNumArray
    mov ecx, count
    sub ecx, 2      ; Only fill 28 numbers

    fill_fibNumArray:
        mov eax, [esi]
        add eax, [esi + TYPE fibNumArray]
        mov [esi + 2 * TYPE fibNumArray], eax
        add esi, TYPE fibNumArray
        LOOP fill_fibNumArray

    lea esi, fibNumArray
    mov ecx, count

    print_array:
        mov eax, [esi]
        call WriteDec

        ; Skip "," for the last element
        dec ecx
        jz done

        mov al, ","
        call WriteChar
        mov al, " "
        call WriteChar

        add esi, TYPE fibNumArray ; Move to the next element

        jmp print_array
    
done:
    call Crlf
    exit
main ENDP
END main