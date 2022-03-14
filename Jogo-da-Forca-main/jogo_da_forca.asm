data segment ;inicio data segment
    intro_message db "Escolha um dos seguintes modos de jogo:", 13, 10, "1: 1 Jogador;", 13, 10, "2: 2 Jogadores;$"
    escolha db "Escolha: $"
    tamanho db "Tamanho da palavra: $"
    message_0 db "JOGO DA FORCA!$" 
    message_1 db "Designed by: Eduardo Chaves 70611 & Jo", 198, "o Rodrigues 70579$"
    message2_0 db "Modo 2 jogadores$"                                                   ;frases para usar posteriormente no code segment
    message2_00 db "Insira o tema da sua palavra (max 9 caracteres): $"
    message2_1 db "Insira o tamanho da sua palavra         (max 9): $"
    message2_2 db "Insira a sua palavra         (max 9 caracteres): $"
    t_letter db "Insira uma letra: $"
    new_line db 13, 10, "$"
    win_message db "Ganhaste o jogo, parab", 130, "ns!$"
    lose_message db "Perdeste o jogo, mais sorte para a pr", 162, "xima!$"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    irtro_optn db '0', "$"
    tema db "Tema:          $"
    tema_n db '2', "$"                           ;definições para tema e word para ambos os modos de jogo
    word_n db '5', "$"
    word db "         $"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    tema0 db "Tema: Animais$"
      
    tema0word0 db "panda$"
    tema0word1 db "baleia$"
    tema0word2 db "canguru$"
    tema0word3 db "elefante$"
    tema0word4 db "tartaruga$"                    ;tema e palavras do jogo de 1 jogador
                             
    tema1 db "Tema: Pa", 161, "ses$"
    
    tema1word0 db "china$"
    tema1word1 db "brasil$"
    tema1word2 db "espanha$"
    tema1word3 db "alemanha$"
    tema1word4 db "dinamarca$"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    discovered1 db "-$"
    discovered2 db "--$" 
    discovered3 db "---$"
    discovered4 db "----$"
    discovered5 db "-----$"            ;tracinhos para cada size da palavra
    discovered6 db "------$" 
    discovered7 db "-------$"
    discovered8 db "--------$"
    discovered9 db "---------$"
    word_size db '0', "$"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
    lives db 6                   
    hits db 0
    errors db 0
    turn db 0
    letrasjs db "Letras que j", 160, " sa", 161, "ram: $"
    letters db "                              $"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;bonecos correspondentes a cada vida perdida    
    boneco0 db "    +---+", 13, 10, "    |   |", 13, 10, "        |", 13, 10, "        |", 13, 10, "        |", 13, 10, "        |", 13, 10, "  =========",'$'
    boneco1 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "        |", 13, 10, "        |", 13, 10, "        |", 13, 10, "  =========",'$'
    boneco2 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "    |   |", 13, 10, "        |", 13, 10, "        |", 13, 10, "  =========",'$'  
    boneco3 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "   /|   |", 13, 10, "        |", 13, 10, "        |", 13, 10, "  =========",'$'  
    boneco4 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "   /|\  |", 13, 10, "        |", 13, 10, "        |", 13, 10, "  =========",'$'
    boneco5 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "   /|\  |", 13, 10, "   /    |", 13, 10, "        |", 13, 10, "  =========",'$'
    boneco6 db "    +---+", 13, 10, "    |   |", 13, 10, "    O   |", 13, 10, "   /|\  |", 13, 10, "   / \  |", 13, 10, "        |", 13, 10, "  =========",'$' 
    
data ends ;fim data segment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
code segment  ;inicio code segment
    start:                                 
        mov ax, data                       ; implantar os regitos da data
        mov ds, ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    intro:
        lea dx, message_0
        call print 
        lea dx, new_line
        call print 
        call print
        lea dx, message_1      
        call print 
        lea dx, new_line
        call print 
        call print
        
        lea dx, boneco6
        call print
        
        lea dx, new_line
        call print 
        call print                           ;imprime frases do data segment
        
        lea dx, intro_message
        call print
        
        lea dx, new_line
        call print 
        call print
        
        lea dx, escolha
        call print
        mov ah, 1
        int 21h
        
        cmp al, '2'
        je pre_main2                       ;verifica se o kodo de jogo e' 1 jogador ou 2 jogadores
             
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;a partir daqui so' modo 1 jogador            
    rand_tema:
        mov ah, 00h
        int 1ah
    
        mov ax, dx
        xor dx, dx                         ;atribui um nu'mero entre 0 e 1 para o tema visto que so' temos 2
        mov cx, 2
        div cx
    
        add dl, '0'
        mov tema_n, dl
           
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    rand_word:
        mov ah, 00h
        int 1ah
    
        mov ax, dx
        xor dx, dx
        mov cx, 5                          ;atribui um nu'mero entre 0 e 4 para selecionra a palavra visto que so' temos 4
        div cx
    
        add dl, '0'
        mov word_n, dl
        
        cmp word_n, '4'
        je palavra4
        
        cmp word_n, '3'
        je palavra3
        
        cmp word_n, '2'
        je palavra2
        
        cmp word_n, '1'
        je palavra1
        
        mov al, '5'                          
        mov word_size, al                    
        jmp main1
            
        palavra1:
            mov al, '6'
            mov word_size, al
            jmp main1
                                              ;definimos o tamanho da palavra através deste rand pois ambas as palavras de cada tema com
        palavra2:                             ;o mesmo nu'mero teem o mesmo size
            mov al, '7'
            mov word_size, al
            jmp main1
         
        palavra3:
            mov al, '8'
            mov word_size, al
            jmp main1
        
        palavra4:
            mov al, '9'
            mov word_size, al
            jmp main1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
    main1:
        call clear_screen
        lea dx, message_0
        call print 
        lea dx, new_line
        call print                                     ;imprime frases do data segment
        call print
        lea dx, message_1
        call print 
        lea dx, new_line
        call print 
        call print
        
        mov bh, ds:[errors]
        cmp bh, 6
        je toy_6
        
        cmp bh, 5
        je toy_5
                                                 ;verifica consoante o nuu'mero de erros que boneco deve colocar
        cmp bh, 4
        je toy_4
        
        cmp bh, 3
        je toy_3 
        
        cmp bh, 2
        je toy_2 
        
        cmp bh, 1
        je toy_1
        
        lea dx, boneco0
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue0:
        lea dx, new_line
        call print 
        call print
        
        lea dx, letrasjs
        call print               ;imprime as letras que ja' foram digitadas
        
        lea dx, letters
        call print
        
        lea dx, new_line
        call print 
        call print    
        
        cmp tema_n, '0'         ;verifica qual o tema e imprime
        jne tema_1
        
        lea dx, tema0
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue1:
    
        lea dx, new_line
        call print 
        call print     
        
        lea dx, tamanho
        call print
        
        lea dx, word_size                 ;identifica o tamanho da palavra
        call print
        
        lea dx, new_line
        call print 
        call print
        
        cmp word_size, '9'
        je dw09
        
        cmp word_size, '8'
        je dw08
        
        cmp word_size, '7'
        je dw07
        
        cmp word_size, '6'
        je dw06     
                                           ;imprime os tracinhos
        lea dx, discovered5
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    continue2:      
        lea dx, new_line
        call print    
        call print
    
        call verific   ;verifica se ja' estamos perante uma vito'ria ou derrota
    
        lea dx, t_letter ;pede para digiar uma letra
        call print
    
        call read_keyboard  ; le do teclado a letra e coloca-a nas letras digitadas ao mesmo tempo 
        call update1     ;verifica se estamos perante um erro ou um acerto

        call clear_screen   ;limpa o ecra  
        loop main1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        tema_1:
            lea dx, tema1                   ;seleciona tema
            call print
            jmp continue1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                     
        toy_1:
            lea dx, boneco1
            call print
            jmp continue0
            
        toy_2:
            lea dx, boneco2
            call print
            jmp continue0
            
        toy_3:
            lea dx, boneco3
            call print                             ;seleciona boneco
            jmp continue0
            
        toy_4:
            lea dx, boneco4
            call print
            jmp continue0
            
        toy_5:
            lea dx, boneco5
            call print
            jmp continue0
            
        toy_6:
            lea dx, boneco6
            call print
            jmp continue0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
        dw06:
            lea dx, discovered6
            call print
            jmp continue2
            
        dw07:
            lea dx, discovered7
            call print                             ;seleciona tamanho dos tracinhos
            jmp continue2
            
        dw08:
            lea dx, discovered8
            call print
            jmp continue2

        dw09:
            lea dx, discovered9
            call print
            jmp continue2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
       
    update1:
        cmp tema_n, '0'
        jne tema_01
        
        cmp word_n, '4'
        je t0_word4
                                             ;seleciona palavra
        cmp word_n, '3'
        je t0_word3
        
        cmp word_n, '2'
        je t0_word2
        
        cmp word_n, '1'
        je t0_word1
        
        lea si, tema0word0 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;          
    continue3:
        cmp word_size, '9'
        je dw9
        
        cmp word_size, '8'
        je dw8
                                            ;seleciona comprimento dos tracinhos
        cmp word_size, '7'
        je dw7
        
        cmp word_size, '6'
        je dw6
        
        lea di, discovered5     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue4:
        mov bx, 0    
        update1_loop:
            cmp ds:[si], "$"
            je end_word1
    
            ; verifica se a letra ja' foi anteriormente atribui'da
            cmp ds:[di], al
            je increment1
    
            ; verifica se a letra esta' na palavra    
            cmp ds:[si], al
            je equal1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 
            increment1:
                inc si
                inc di   
                jmp update1_loop    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 
            equal1:
                mov ds:[di], al
                inc hits
                mov bx, 1
                jmp increment1             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
            end_word1:  
                cmp bx, 1
                je end_update1
    
        inc errors  ;incrementa nos erros caso nao salte para ofim ate' ao fim da palavra    
    
        end_update1:
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
        tema_01:
            cmp word_n, '4'
            je t1_word4
        
            cmp word_n, '3'
            je t1_word3
                                                   ;seleciona palavra
            cmp word_n, '2'
            je t1_word2
        
            cmp word_n, '1'
            je t1_word1
            
            lea si, tema1word0
            jmp continue3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        t0_word1:
            lea si, tema0word1
            jmp continue3 
            
        t0_word2:
            lea si, tema0word2
            jmp continue3
                                                ;seleciona palavra
        t0_word3:
            lea si, tema0word3
            jmp continue3
            
        t0_word4:
            lea si, tema0word4
            jmp continue3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
        t1_word1:
            lea si, tema1word1
            jmp continue3 
            
        t1_word2:
            lea si, tema1word2
            jmp continue3                        ;seleciona palavra
            
        t1_word3:
            lea si, tema1word3
            jmp continue3
            
        t1_word4:
            lea si, tema1word4
            jmp continue3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             
         dw6:
            lea di, discovered6
            jmp continue4 
            
         dw7:
            lea di, discovered7                  ;seleciona tamanhoa dos tracinhos
            jmp continue4

         dw8:
            lea di, discovered8
            jmp continue4
            
         dw9:
            lea di, discovered9
            jmp continue4  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;so' modo 2 jogadores a partir daqui               
    
    pre_main2:
        call clear_screen
        call define                  ;define todas as varia'veis necessa'rias para um jogo num modo 2 jogadores
        call clear_screen        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    main2:
        lea dx, message_0
        call print 
        lea dx, new_line
        call print 
        call print                               ;imprime frases do data segment
        lea dx, message_1
        call print 
        lea dx, new_line
        call print 
        call print
        
        mov bh, ds:[errors]
        cmp bh, 6
        je toy2_6
        
        cmp bh, 5
        je toy2_5
        
        cmp bh, 4
        je toy2_4                               ;verifica consoante o nuu'mero de erros que boneco deve colocar
        
        cmp bh, 3
        je toy2_3 
        
        cmp bh, 2
        je toy2_2 
        
        cmp bh, 1
        je toy2_1
        
        lea dx, boneco0
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue00:
        lea dx, new_line
        call print 
        call print
        
        lea dx, letrasjs             ;imprime as letras que ja' foram digitadas
        call print
        
        lea dx, letters
        call print
        
        lea dx, new_line
        call print 
        call print    
        
        lea dx, tema
        call print
    
        lea dx, new_line
        call print 
        call print     
        
        lea dx, tamanho                 ;identifica o tamanho da palavra
        call print
        
        lea dx, word_size
        call print
        
        lea dx, new_line
        call print 
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        cmp word_size, '9'
        je dw009
        
        cmp word_size, '8'
        je dw008
        
        cmp word_size, '7'
        je dw007
        
        cmp word_size, '6'
        je dw006                             ;imprime os tracinhos
        
        cmp word_size, '5'
        je dw005
        
        cmp word_size, '4'
        je dw004
        
        cmp word_size, '3'
        je dw003
        
        cmp word_size, '2'
        je dw002
                
        lea dx, discovered1              
        call print
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;          
    continue01:    
        lea dx, new_line
        call print    
        call print
    
        call verific       ;verifica se ja' estamos perante uma vito'ria ou derrota
    
        lea dx, t_letter   ;pede para digiar uma letra
        call print
    
        call read_keyboard ; le do teclado a letra e coloca-a nas letras digitadas ao mesmo tempo  
        call update2       ;verifica se estamos perante um erro ou um acerto

        call clear_screen  ;limpa o ecra   
        loop main2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
        toy2_1:
            lea dx, boneco1
            call print
            jmp continue00
            
        toy2_2:
            lea dx, boneco2
            call print
            jmp continue00
            
        toy2_3:
            lea dx, boneco3
            call print
            jmp continue00              ;seleciona o boneco
            
        toy2_4:
            lea dx, boneco4
            call print
            jmp continue00
            
        toy2_5:
            lea dx, boneco5
            call print
            jmp continue00
            
        toy2_6:
            lea dx, boneco6
            call print
            jmp continue00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    dw002:
        lea dx, discovered2
        call print
        jmp continue01

    dw003:
        lea dx, discovered3
        call print
        jmp continue01
        
    dw004:
        lea dx, discovered4
        call print                              ;seleciona o tamanho dos tracinhos
        jmp continue01

    dw005:
        lea dx, discovered5
        call print
        jmp continue01

    dw006:
        lea dx, discovered6
        call print
        jmp continue01
        
    dw007:
        lea dx, discovered7
        call print
        jmp continue01

    dw008:
        lea dx, discovered8
        call print
        jmp continue01
        
    dw009:
        lea dx, discovered9
        call print
        jmp continue01        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                             
    update2:
        lea si, word
        
        cmp word_size, '9'
        je dw0009
        
        cmp word_size, '8'
        je dw0008
        
        cmp word_size, '7'
        je dw0007
        
        cmp word_size, '6'                    ;seleciona comprimento dos tracinhos
        je dw0006
        
        cmp word_size, '5'
        je dw0005
        
        cmp word_size, '4'
        je dw0004
        
        cmp word_size, '3'
        je dw0003
        
        cmp word_size, '2'
        je dw0002
        
        lea di, discovered1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue02:     
        mov bx, 0
        
        update2_loop:
            cmp ds:[si], "$"
            je end_word2
    
            ; verifica se a letra ja' foi anteriormente atribui'da
            cmp ds:[di], al
            je increment2
    
            ; verifica se a letra esta' na palavra    
            cmp ds:[si], al
            je equal2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 
            increment2:
                inc si
                inc di   
                jmp update2_loop    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 
            equal2:
                mov ds:[di], al
                inc hits
                mov bx, 1
                jmp increment2             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
            end_word2:  
                cmp bx, 1
                je end_update2
    
        inc errors     ;incrementa nos erros caso nao salte para ofim ate' ao fim da palavra  
    
        end_update2:
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        dw0002:
           lea di, discovered2
           jmp continue02 
           
        dw0003:
           lea di, discovered3
           jmp continue02

        dw0004:
           lea di, discovered4
           jmp continue02
           
        dw0005:                                  ;seleciona comprimento dos tracinhos
           lea di, discovered5
           jmp continue02
           
        dw0006:
           lea di, discovered6
           jmp continue02 
           
        dw0007:
           lea di, discovered7
           jmp continue02

        dw0008:
           lea di, discovered8
           jmp continue02
           
        dw0009:
           lea di, discovered9
           jmp continue02
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
    define:
        lea dx, message2_0
        call print
        
        lea dx, new_line                      ;imprime frases do data segment
        call print    
        call print
        
        lea dx, message2_00
        call print
        
        lea bx, tema
        mov si, 8       ;inicio do contador
        mov cx, 9      ;tamanho do loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    ler00:   
        mov ah, 1     
        int 21h
        cmp al, [13, 10]
        je continue03                         ;pede o tema ate' digitar enter e guarda-o em frente a tema: no vetor caractere a caractere
        mov byte ptr[bx + si], al   
        inc si              
        loop ler00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
    continue03:
        lea dx, new_line
        call print 
        call print
                                             ;pede o tamanho da palavra e coloca-o em word_size
        lea dx, message2_1
        call print
        
        mov ah, 1
        int 21h
        mov word_size, al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;            
    continue04:
        lea dx, new_line
        call print 
        call print
        
        lea dx, message2_2                 ;pede a palavra
        call print
        
        lea bx, word    
        mov si, 0       
        mov cx, 9      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ler01:   
        mov ah, 1       
        int 21h
        cmp al, [13, 10]
        je continue05                     ;guarda a palavra digitada na word caractere a caractere
        mov byte ptr[bx + si], al
        inc si             
        loop ler01
        
    continue05:
    ret    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    verific:                   
        mov bl, ds:[lives]
        mov bh, ds:[errors]
        cmp bl, bh
        je game_over
                                          ;verifica se o jogo foi ganho ou perdido
        mov bl, ds:[word_size]
        sub bl, '0'
        mov bh, ds:[hits]
        cmp bl, bh
        je game_win
    
        ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
         
    game_over:      
        lea dx, lose_message               ;imprime a frase de derrota
        call print

        lea dx, new_line
        call print 
        call print
        
        mov ah, 1
        int 21h
            
        jmp fim

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    game_win:     
        lea dx, win_message
        call print                          ;imprime a frase de vito'ria
        
        lea dx, new_line
        call print 
        call print
        
        mov ah, 1
        int 21h
        
        jmp fim          
              
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    clear_screen:     
        mov ah, 0fh
        int 10h   
    
        mov ah, 0                           ; get e set do video mode
        int 10h
    
        ret
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    read_keyboard:     
        mov si, 0
        
        mov ah, 1
        int 21h
        loop01:
            cmp letters[si], ' '
            je p01                        ;le uma letra do teclado e garda-a em letters
            
            add si, 2
            loop loop01
            
        p01:
        mov letters[si], al
    
        ret
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    print:     
        mov ah, 9
        int 21h                           ;imprime as frases no ecra
    
        ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    fim:        
    end start
code ends ;fim do code segment