
INCLUDE Irvine32.inc
.data
arr_size = 7777
unsolvedfile BYTE "files\omarunsolved.txt",0
solvedfile BYTE "files\omarsolved.txt",0
arr BYTE arr_size DUP(?)
arr2 BYTE arr_size DUP(?)
unsolved BYTE arr_size DUP(?)
solved BYTE arr_size DUP(?)
string   byte " enter Solution : ",0
value    byte ?
row     dword  ?
col     dword ?
st1     byte  "Correct Answer",0
incrementation  byte ?
r byte "Enter Row :" ,0
c1 byte "Enter Colomn :" ,0
wrongAns byte "Wrong Answer",0
.code
;---------------------------------------------------------------------------------------
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
movzx ecx,byte ptr[esi-1] ;; move el value el fel esi (solved) fl ecx
mov eax,ecx
sub eax,'0'
;;call writedec
cmp value,al;; compare el fel ecx bel enetered value (law equal zero flag hykon b one
jnz l1 ;; jump if xero flag=zero
mov edx,offset st1 ;; move offset string okay
call writestring ;; write okay 
RET
l1: mov edx,offset wrongAns;; law msh zy ba3d hygy hena ( el mafrood cout wrong answer )
    call writestring
RET
check ENDP ;; end function
main PROC

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
	; unsolved file 

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
	; solved file
	;;mov edx , offset solved
	;;call WriteString       
	;;call crlf
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
   call check ;; proc call

	exit
main ENDP

END main