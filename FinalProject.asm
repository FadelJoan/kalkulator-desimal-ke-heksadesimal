.MODEL small

.STACK 100h

.DATA                                  
interface1 db 0dh, 0ah, '-------------------------------------- $'
tittle     db 0dh, 0ah, '| Kalkulator desimal ke heksadesimal | $'
interface3 db 0dh, 0ah, '--------------------------------------$'
message    db 0dh, 0ah, ' masukkan bialngan desimal : $'          
interface5 db 0dh, 0ah, '-------------------------------------- $'   
result     db           '  ialah hasil hexadesimal-nya      $'  
interface7 db 0dh, 0ah, '------------------------------------ $' 


.CODE
start:
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    mov dx, offset interface1
    int 21h   
    
    ; Menampilkan judul
    mov ah, 9
    mov dx, offset tittle
    int 21h 
    
    mov ah, 9
    mov dx, offset interface3
    int 21h          
                 
    ; Menampilkan pesan
    mov ah, 9
    mov dx, offset message
    int 21h
    
    mov cx, 10 ; Menetapkan 10 ke dalam cx, karena akan dikalikan dengan 10
    
input:
    mov ah, 1
    int 21h	; Membaca angka dari input
    cmp al, 13 ; Jika 'enter', keluar dari loop
    je input_end       
          
    sub al, 48 ; Mengurangkan kode ASCII agar mendapatkan angka
    mov ah, 0
    push ax ; Menyimpan angka yang dibaca ke dalam stack
    mov ax, bx ; bx - nilai akhir angka
    mul cx ; Mengalikan nilai sebelumnya dengan 10
    mov bx, ax
    pop ax
    add bx, ax ; Menambahkan angka yang baru dibaca ke dalam nilai yang diinginkan
    jmp input ; Mengulang loop
      
input_end:
       
    mov ah, 9
    mov al, offset interface5
    int 21h 
        
    mov ax, bx ; Menyimpan nilai akhir angka di dalam ax
    mov cx, 16 ; Membagi dengan 16
    mov bx, 0 ; Menggunakan bx untuk menghitung berapa angka yang dimasukkan ke dalam stack / berapa sisa yang didapatkan
    
conversion:
    div cx ; DX:AX / CX, DX - sisa hasil bagi
    push dx ; Menyimpan sisa hasil bagi ke dalam stack
    mov dx, 0
    inc bl ; Menghitung berapa angka yang dimasukkan ke dalam stack
    cmp ax, 0 ; Jika hasil bagi tidak sama dengan 0, mengulang loop
    jne conversion
    
    mov ah, 02h
    mov dl, 10 ; Pindah ke baris baru
    int 21h
    mov ah, 02h
    mov dl, 13 ; Pindah ke kolom baru
    int 21h
    
output_start:
    pop ax ; Mengambil sisa hasil bagi dari stack
    cmp al, 9
    jg output_hex ; Memeriksa, apakah angka lebih besar dari 9
    
output_dec:
    add al, 48 ; Menambahkan kode ASCII untuk menghasilkan angka desimal
    mov ah, 2
    mov dl, al ; Menyimpan angka ke dalam dl untuk ditampilkan
    int 21h ; Menampilkan angka
    inc bh ; Menghitung berapa angka yang telah ditampilkan
    cmp bh, bl ; Jika jumlah angka yang telah ditampilkan belum sama dengan jumlah angka yang dimasukkan ke dalam stack, mengulang loop
    jne output_start
    jmp output_end
    
output_hex: 
    add al, 55 ; Menambahkan kode ASCII untuk menghasilkan angka heksadesimal
    mov ah, 2 
    mov dl, al ; Menyimpan angka ke dalam dl untuk ditampilkan
    int 21h ; Menampilkan angka
    inc bh ; Menghitung berapa angka yang telah ditampilkan
    cmp bh, bl ; Jika jumlah angka yang telah ditampilkan belum sama dengan jumlah angka yang dimasukkan ke dalam stack, mengulang loop
    jne output_start
    
output_end:
    mov ah, 9
    mov dx, offset result ; Menampilkan pesan
    int 21h
    mov ah, 9
    mov dx, offset interface1
    int 21h   
    
    mov ax, 4C00h
    int 21h

end start
