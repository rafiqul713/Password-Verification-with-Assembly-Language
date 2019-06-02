; RAFIQUL ISLAM



;Macro is Define here
printMessage macro msg
    mov ah,09h
    mov dx,offset msg
    int 21h
endm
 


;here is data segment  
_data segment
   
    cr equ 13 
    lf equ 10
   
    ;here declare all variable used in the program
    saved_password db "12345",cr 

    team_member db "Team Members: ",lf,lf,cr,"$"
    team_member1 db "Rafiqul Islam",lf,cr,"ID: 131014042",lf,lf,cr,"$"
    team_member2 db "Md Nazmus Shakib",lf,cr,"ID: 131014016",lf,lf,cr,"$"

    msg1 db cr,lf,"Enter password:  $"
    msg2 db cr,lf,"Please Enter password again:  $"
    msg3 db cr,lf,"Password does not match  $"
    msg4 db cr,lf,"Welcome...! Password is Matched  $"
    
    given_password db 80 dup(?)
    
    
_data ends
 
 ; Here is code segment
_code segment
                     
            ;Define Procedure
            proc Authorized
            
            printMessage msg4
            mov ah,4ch
            mov al,00h
            int 21h
            ret
            
            Authorized endp
             
             
            ;Define Procedure 
            proc notAuthorized
                
            printMessage msg3
            printMessage msg2
            jmp input_password
            
            notAuthorized endp           

           ;initialize segement
    assume cs:_code,ds:_data
    
    
    start:
        mov ax,_data
        mov ds,ax
        
        printMessage team_member
        printMessage team_member1
        printMessage team_member2
        printMessage msg1
         

    input_password:
        mov si,offset given_password
        
    readchar:
        mov ah,08h
        int 21h
   
        mov [si],al
        
        
        push ax
        mov ah,02
        mov dl,'*'
        int 21h
        pop ax
        
        
        inc si
        cmp al,cr
        jne readchar
        
        mov si,offset saved_password
        mov di,offset given_password
        
     matchingPassword:
        mov al,[si]
        cmp al,[di]
        jne call  notAuthorized
        
        inc si
        inc di
        cmp al,cr
        jne matchingPassword
        je call Authorized   
        
                    
     _code ends
            end start
