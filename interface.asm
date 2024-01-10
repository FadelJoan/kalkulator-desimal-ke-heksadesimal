.MODEL small
.STACK 100h

.DATA  
interface1 db 0dh, 0ah,'------------------------------ $'
interface2 db 0dh, 0ah,'|                            | $'
interface3 db 0dh, 0ah,'------------------------------ $'
interface4 db 0dh, 0ah,'|                            | $'  
interface5 db 0dh, 0ah,'------------------------------ $'
interface6 db 0dh, 0ah,'|                            | $'
interface7 db 0dh, 0ah,'------------------------------ $' 

.CODE
start:  
    mov ax, @data
    mov ds, ax   
    
    mov ah, 9
    mov dx, offset interface1
    int 21h   
    
    mov ah, 9
    mov dx, offset interface2
    int 21h         
    
    mov ah, 9
    mov dx, offset interface3
    int 21h                  
    
    mov ah, 9
    mov dx, offset interface4
    int 21h 
    
    mov ah, 9
    mov dx, offset interface5
    int 21h 
       
    mov ah, 9
    mov dx, offset interface6
    int 21h     
           
    mov ah, 9
    mov dx, offset interface7
    int 21h         
                             
end start
