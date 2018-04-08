
INCLUDE Irvine32.inc
.data
arr_size = 7777 ;;initial array size
unsolvedfile BYTE "files\omarunsolved.txt",0 ;;unsolved file path
solvedfile BYTE "files\omarsolved.txt",0;;solved file path
arr BYTE arr_size DUP(?)
arr2 BYTE arr_size DUP(?)
unsolved BYTE arr_size DUP(?) ;;unsolved array shaghakleen 3alih
currentgrid byte arr_size dup(?);;current grid array shaghaleen 3alih 
solved BYTE arr_size DUP(?);;solved grid array shaghaleen 3alih
string   byte " enter Solution : ",0 ;; to cout enter solution
value    byte 0 ;; to stor value enetered by the user
row     dword  ?;;to store row number
col     dword ?;;to store column number
st1     byte  "Correct Answer",0 ;; to cout correct answer
WRONG_ANSWERS_COUNT byte 0 ;; to count wrong answers
CORRECT_ANSWERS_COUNT byte 0 ;; to count correct answers
r byte "Enter Row :" ,0 ;; to cout enter row
c1 byte "Enter Colomn :" ,0;; to cout enter col
wrongAns byte "Wrong Answer",0;; to cout wrong answer
status1 byte "NUMBER OF WRONG ANSWERS",0 ;; cout  number of wrong answers
status2 byte "NUMBER OF CORRECT ANSWERS",0;;cout number of wrong answers
formula byte ? ;;to store calculated index
space byte " ",0 ;; to print spaces
colnum byte " 1 2 3 4 5 6 7 8 9",0 ;; print column numbers
line  byte "-------|-----|-----|",0 ;; print line delimiters 
vertical byte"|",0 ; print vertical delimiter
.code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FILL CURRENT GRID;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
readunsolvedtocurrent PROC
 mov edx,OFFSET unsolvedfile
	call OpenInputFile
    mov edx,OFFSET arr
	mov ecx,arr_size
	call ReadFromFile
    mov esi,offset currentgrid
	mov edx, offset arr
    mov ecx, 9
	l1:
    mov ebx , ecx ;save ecx
	mov ecx, 9
	l2:
	movzx edi ,byte ptr[edx]
	mov [esi],edi
	inc edx
	inc esi 
	loop l2
	mov ecx,ebx
	inc edx
	inc edx
	loop l1
ret
readunsolvedtocurrent ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;PRINT CURRENT GRID AFTER EVERY ENTERED VALUE;;;;;;;;;;;;;;;;
printCurrentGrid PROC
mov edx,offset space ;;initial space
call writestring
mov eax,2
Call SetTextColor ;;change colour
mov edx,offset colnum ;;print col num
call writestring
call crlf
mov esi,offset currentgrid
mov ecx,81 ;; size of array 
mov ebx,0 ;; counter to new line
mov edx,1
mov edi,1
;;;;;;;;;;;;;;;to write row number
     mov eax,edi
	 call writedec
	 inc edi
	 pushad
	 mov edx,offset space
	 call writestring
	 popad
;;;;;;;;;;;;;;;;
mov eax,15 ;;change colour
Call SetTextColor 
add value,'0' ;;change value from int to string character
l1:
     cmp dl,formula ;;compare current index with the index to place the new value in
	 jnz normal
	 mov al,value ;; if equal then mov the value to al 
	 mov [esi],al ;; mov al to the current grid array
	 jmp complete
	 normal:
     mov al,[esi] ;; if not equal then complete 3ady
	 jmp complete
	 complete:
	 mov al,[esi]
	 call writechar
	 ;;;type space
	 pushad
	 mov edx,offset space
	 call writestring
	 popad
	 ;;incrementations
	 inc esi
	 inc ebx
	 inc dl
	 ;;;;;;;;;;;;;;;;;
	 cmp ebx,9 ;; compare to move to new line
	 jnz l2 
	 call crlf ;; new line after every 9 elements
	 pushad
	 mov edx,offset line
     call writestring
	 popad
	 call crlf
	 mov eax,2
     Call SetTextColor;;change colour
     mov eax,edi ;;write row num
	 call writedec
	 inc edi
	 pushad
	 mov edx,offset space;;write space
	 call writestring
	 popad
	 mov eax,15 ;;change colour
     Call SetTextColor
	 mov ebx,0 ;;reinitialize ebx to start counting new row
	 loop l1
	 jmp skip
	 l2:
	 loop l1
	 skip:
ret
printCurrentgrid  ENDP
;----------------------------------READ ARRAY----------------------------------------------
;Reads array
;------------------------------------------------------------------------------------------
READARRAY PROC
; unsolved file
    mov edx,OFFSET unsolvedfile
	call OpenInputFile
    mov edx,OFFSET arr
	mov ecx,arr_size
	call ReadFromFile
    mov esi,offset unsolved
	mov edx, offset arr
    mov ecx, 9
	l1:
    mov ebx , ecx ;save ecx
	mov ecx, 9
	l2:
	movzx edi ,byte ptr[edx]
	mov [esi],edi
	inc edx
	inc esi 
	loop l2
	mov ecx,ebx
	inc edx
	inc edx
	loop l1
    ;unsolved file 
	;solved file 
	mov edx,OFFSET solvedfile
	call OpenInputFile
	mov edx,OFFSET arr2
	mov ecx,arr_size
	call ReadFromFile
	mov esi,offset solved
	mov edx, offset arr2
	mov ecx, 9
	l3:
	mov ebx , ecx ;save ecx
	mov ecx, 9
	l4:
	movzx edi ,byte ptr[edx]
	mov [esi],edi
	inc edx
	inc esi 
    loop l4
	mov ecx,ebx
	inc edx
	inc edx
    loop l3
	;solvedfile
ret
READARRAY ENDP
;--------------------------------------PLAYERSTATUS------------------------------------------
;Prints  the number of correct answers 
;Prints number of Wrong Answers
;prints time taken 
;----------------------------------------------------------------------------------------
PLAYER_STATUS  PROC
mov al,WRONG_ANSWERS_COUNT  ; move number of wrong answers to al to b e printed
mov edx,offset status1
call writestring
call crlf
call writedec ;; print num
call crlf
mov al,CORRECT_ANSWERS_COUNT ; move number of correct answers to al to be printed
mov edx,offset status2
call writestring
call crlf
call writedec ;; print num
call crlf
ret
PLAYER_STATUS ENDP
;--------------------------------------OPTION 2------------------------------------------
;Prints  the unsolved  Grid -- Clear 
;receives the offset of the unsolved grid
;prints it out
;----------------------------------------------------------------------------------------
CLEAR_GRID  PROC
mov esi,offset unsolved
mov ecx,81 ;;size of array
mov ebx,0 ;; cunter to move to new line
l1:
     mov al,[esi]
	 call writechar
	 inc esi
	 inc ebx
	 cmp ebx,9
	 jnz l2
	 call crlf ;; new ine after every 9 elements
	 mov ebx,0
	 loop l1
	 jmp skip
	 l2:
	 loop l1
	 skip:
ret
CLEAR_GRID ENDP
;-------------------------------------OPTION 1-------------------------------------------
;Prints Solved Grid (option 1)
;receives the offset of the solved grid
;prints it out
;----------------------------------------------------------------------------------------
PRINTSOLVED PROC
mov esi,offset solved
mov ecx,81 ;; size of array 
mov ebx,0 ;; counter to new line
l1:
     mov al,[esi]
	 call writechar
	 inc esi
	 inc ebx
	 cmp ebx,9
	 jnz l2
	 call crlf ;; new line after every 9 elements
	 mov ebx,0
	 loop l1
	 jmp skip
	 l2:
	 loop l1
	 skip:
	 
ret
PRINTSOLVED ENDP
;----------------------------------OPTION 3----------------------------------------------
;Checks the value enetered by the user wheather it fit the grid or no
;receives the value entered by the user,the row and colomn to place the value in 
;receives the offset of the solved suduko grid 
;prints for every input if it is correct or no 
;----------------------------------------------------------------------------------------
check PROC
mov ebx,row;;formula
dec ebx;;formula
mov eax,9;;formula
MUL ebx;;formula
mov ebx,eax;;fprmula
add ebx,col;;formula
;;formula=(row-1)*9+col
add esi,ebx ;; add 3l offset value el formula
add edi,ebx ;; add 3l offset value el formula
mov formula,bl
movzx ecx,byte ptr[esi-1] ;; move el value el fel esi (solved) fl ecx
mov eax,ecx
sub eax,'0'
;;call writedec
cmp value,al;; compare el fel ecx bel enetered value (law equal zero flag hykon b one
jnz l1 ;; jump if xero flag=zero
mov edx,offset st1 ;; move offset string okay
mov eax,2
call SetTextColor
call writestring ;; write correctanswer
call crlf
pushad
call printcurrentgrid
popad
mov eax,15
Call SetTextColor
inc CORRECT_ANSWERS_COUNT
RET
l1: mov edx,offset wrongAns;; law msh zy ba3d hygy hena ( el mafrood cout wrong answer )
    mov eax,4
	call SetTextColor
    call writestring
	mov eax,15
Call SetTextColor
inc WRONG_ANSWERs_COUNT
RET
check ENDP ;; end function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main PROC
;; call func readarray
   pushad
   call READARRAY
   popAD 
   mov edx,offset unsolved
   mov ecx,81
   call writestring
   call crlf
;;call func ClearGrid
   pushad
   call CLEAR_GRID
   popad
;;call function readunsolvedtocurrent
   PushAD
   call readunsolvedtocurrent
   POPAD
;;start of programme
   mov edx , offset string ;;count enter number
   call writestring
   call readdec;; fel acx 3ndi el value entered
   mov value ,al
   mov edx,offset r
   call writestring ;;cout enter row
   call readdec ;; enter row
   mov row,eax 
   mov edx,offset c1
   call writestring ;; cout enter row
   call readdec ;; enter col
   mov col,eax
   mov esi,offset solved ;;move offset of arrays
   mov edi ,offset unsolved
;;; call function check
   pushAD
   call check 
   call crlf
   POPAD
;; call function PRINTSOLVED
   PushAD
   call PRINTSOLVED
   POPAD
   call crlf
;;Call Function Clear Grid
   pushAD
   call CLEAR_GRID
   popAD
;; Call function PLAYER Status
   pushAD
   call PLAYER_STATUS
   popAD
	exit
main ENDP

END main