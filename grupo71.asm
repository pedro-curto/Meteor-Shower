; *****************************************************************************
; *                                 GRUPO 71                                  *
; * ------------------------------------------------------------------------- *
; *                                 Autores:                                  *
; *                            Fábio Mata - 102802                            *
; *                           Pedro Curto - 103091                            *
; *                           Pedro Sousa - 102664                            * 
; *****************************************************************************  

; *****************************************************************************
; *                                 Constantes                                * 
; *****************************************************************************

DISPLAYS   		EQU 0A000H  ; endereço dos displays de 7 segmentos (periférico POUT-1)
TEC_LIN    		EQU 0C000H  ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL    		EQU 0E000H  ; endereço das colunas do teclado (periférico PIN)
MASCARA    		EQU 0FH     ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
MASCARA_3b      EQU 07H     ; para isolar os 3 bits de menor peso, para gerar uma col aleatória
LINHA_TECLADO   EQU 8       ; 1ª linha a testar (4ª linha, 1000b)

; Valores das teclas
TECLA_0			EQU 0H		
TECLA_1			EQU 1H
TECLA_2			EQU 2H
TECLA_C			EQU 0CH
TECLA_D			EQU 0DH
TECLA_E			EQU 0EH


DEFINE_LINHA    		  EQU 600AH      ; endereço do comando para definir a linha
DEFINE_COLUNA   		  EQU 600CH      ; endereço do comando para definir a coluna
DEFINE_PIXEL    		  EQU 6012H      ; endereço do comando para escrever um pixel
APAGA_AVISO     		  EQU 6040H      ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 			  EQU 6002H      ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_ECRA			  EQU 6004H 	 ; endereço do comando para selecionar o ecrã
SELECIONA_CENARIO_FUNDO   EQU 6042H      ; endereço do comando para selecionar uma imagem de fundo
SELECIONA_CENARIO_FRONTAL EQU 6046H      ; endereço do comando para selecionar uma imagem de 1º plano
APAGA_CENARIO_FRONTAL     EQU 6044H      ; endereço do comando para apagar o cenário frontal
TOCA_SOM                  EQU 605AH      ; endereço do comando para tocar um som
TOCA_SOM_LOOP             EQU 605CH      ; endereço do comando para tocar um som em loop até ser interrompido
PAUSA_SOM                 EQU 605EH      ; endereço do comando para pausar um som/vídeo
RETOMA_SOM                EQU 6060H      ; endereço do comando para retomar um som/vídeo
TERMINA_SOM               EQU 6066H      ; para de tocar um som especificado

ECRA_NAVE 			EQU  4	; Os meteoros ocupam os ecrãs 0,1,2,3 logo a nave ocupa o ecrã 4

; Constantes representativas de ecrãs de fundo
IMAGEM_INICIO       EQU  0
IMAGEM_JOGO 		EQU  1
IMAGEM_PAUSA 		EQU  2
IMAGEM_FIM_TECLA	EQU  3
IMAGEM_FIM_ENERGIA  EQU  4
IMAGEM_FIM_COLISAO 	EQU  5

; Permite distinguir meteoro bom de mau 
ASTEROIDE    		EQU  0	
NAVE 				EQU  1

LINHA_NAVE        	EQU  28        ; linha da nave (base do ecrã)
COLUNA_NAVE			EQU  30        ; coluna da nave (a meio do ecrã)

LINHA_METEORO		EQU  1 		   ; linha inicial do meteoro

N_METEOROS 			EQU  4 		   ; nº de meteoros que irão existir


; Modos de jogo
MODO_INICIO		EQU 0
MODO_ATIVO		EQU 1
MODO_PAUSA		EQU 2
MODO_FIM		EQU 3

; Efeitos sonoros e música
DISPARO				EQU 0
EXPLOSAO 			EQU 1
APANHA_METEORO		EQU 2
MUSICA_FUNDO		EQU 3
EXPLOSAO_ROVER 		EQU 4
SEM_ENERGIA 		EQU 5

; Largura e altura dos objetos asteróide bom e nave inimiga nas suas diversas fases
LARGURA_OBJETO_1		EQU	1	   
ALTURA_OBJETO_1		    EQU 1

LARGURA_OBJETO_2		EQU	2
ALTURA_OBJETO_2		    EQU 2

LARGURA_OBJETO_3		EQU	3
ALTURA_OBJETO_3		    EQU 3

LARGURA_OBJETO_4		EQU	4
ALTURA_OBJETO_4		    EQU 4

LARGURA_OBJETO_5		EQU	5
ALTURA_OBJETO_5		    EQU 5


MIN_COLUNA		EQU  0		    ; número da coluna mais à esquerda que o objeto pode ocupar
MAX_COLUNA		EQU  63         ; número da coluna mais à direita que o objeto pode ocupar
MIN_LINHA       EQU  0			; número da linha mais acima que o objeto pode ocupar
MAX_LINHA       EQU  31   		; número da linha mais abaixo que o objeto pode ocupar

ATRASO			EQU	 60H		; atraso para limitar a velocidade de movimento do boneco

; atrasos dos processos dos meteoros, para não spawnarem todos ao mesmo tempo
ATRASO_0		EQU  2 		; nº de interrupções do missil que tem que aguardar
ATRASO_1		EQU  12		
ATRASO_2		EQU  22
ATRASO_3		EQU  32

LARGURA_NAVE		   EQU 5		   ; largura da nave
ALTURA_NAVE			   EQU 4           ; altura da nave

COR_NAVE_INICIAL	   EQU 0FBBBH		; cor do pixel: cinza
COR_NAVE_INIMIGA 	   EQU 0FF22H		; cor do pixel: vermelho

COR_ASTEROIDE_INICIAL  EQU 0FBBBH		; cor do pixel: cinza
COR_ASTEROIDE	       EQU 0F4F5H		; cor do pixel: verde

COR_NAVE        	   EQU 0FFF3H       ; cor do pixel: amarelo

COR_EXPLOSAO		   EQU 0F0DFH		; cor do píxel: ciano

COR_MISSIL 			   EQU 0FFFFH	 	; cor do píxel: branco


; Constantes auxiliares de deteção de colisão
NAO_COLIDIU  		   EQU 0
COLIDIU_MISSIL		   EQU 1
COLIDIU_NAVE 		   EQU 2


MOVIMENTOS_MISSIL		EQU 11	; range do míssil
LINHA_MISSIL_INICIAL	EQU 26  ; MAX_LINHA - ALTURA_NAVE (31-5)

ENERGIA_MAXIMA 			EQU 100 ; quantidade máxima de energia (100%)
VALOR_DISPLAY_MAX 		EQU 256 ; valor máximo do display (aparece 100H, que simula 100 decimal)


; *****************************************************************************
; *                  Inicialização das stacks e interrupções                  * 
; *****************************************************************************

PLACE       1000H
	
pilha:
	STACK 100H			; espaço reservado para a pilha 
						; (200H bytes, pois são 100H words)
SP_inicial:				; este é o endereço (1200H) com que o SP deve ser 
						; inicializado. O 1.º end. de retorno será 
						; armazenado em 11FEH (1200H-2)

; inicializar restantes stacks
STACK 100H		
SP_CONTROLO:
STACK 100H				
SP_NAVE:

; stacks para os vários processos dos meteoros
STACK 100H		
SP_METEORO_0:   
STACK 100H
SP_METEORO_1:
STACK 100H
SP_METEORO_2:
STACK 100H
SP_METEORO_3:

; stacks para teclado, display e míssil
STACK 100H
SP_TECLADO:
STACK 100H
SP_DISPLAY:
STACK 100H
SP_MISSIL:

; Tabela com stack pointers iniciais para o processo de cada meteoro
TAB_SP_METEOROS:
	WORD SP_METEORO_0
	WORD SP_METEORO_1
	WORD SP_METEORO_2
	WORD SP_METEORO_3

; Tabela de interrupções
interrupcoes:				
	WORD rot_int_meteoros	
	WORD rot_int_missil		
	WORD rot_int_displays	

; Tabela com os atrasos de cada processo meteoro
atrasos_meteoros: 			
	WORD ATRASO_0
	WORD ATRASO_1
	WORD ATRASO_2
	WORD ATRASO_3


; *****************************************************************************
; *                                 Variáveis                                 * 
; *****************************************************************************

contador_display: WORD 0  		; contador com valor de energia atual
modo_jogo: WORD 0       		; 0 - início; 1 - in-game; 2 - pausa; 3 - terminado
lock_jogo: LOCK 0				; para pausar os processos quando o jogo está inativo
lock_main: LOCK 0				; para impedir o programa de saltar para a zona de processos

; Tabela com variáveis que assinalam a necessidade de verificar colisões
verificar_colisoes: ; 0 se não for para verificar, 1 caso seja
	WORD 0 		
	WORD 0 		
	WORD 0 		
	WORD 0 		

rover_explodiu: WORD 0			; 0 - não explodiu ; 1 - explodiu (para escolher o ecrã de game over)
ha_colisao: WORD 0 				; 0 - não colide, 1 - colide missil, 2 - colide nave
fim_tecla_E: WORD 0 			; 0 - não se clicou na tecla E, 1 - clicou-se
apagar_missil: WORD 0 			; 0 - não é para apagar, 1 - é

; variáveis de interrupção
int_displays: LOCK 0			
int_meteoros: LOCK 0
int_missil: LOCK 0

; posições
pos_nave_colunas: WORD 0
pos_nave_linhas: WORD 0

pos_missil_colunas: WORD 0
pos_missil_linhas: WORD 0

; tabela de alturas dos vários meteoros, para serem apagados de modo independente
altura_meteoros:
	WORD ALTURA_OBJETO_1
	WORD ALTURA_OBJETO_1
	WORD ALTURA_OBJETO_1
	WORD ALTURA_OBJETO_1

tecla_carregada:
	LOCK 0				; LOCK para o teclado comunicar aos restantes processos que tecla detetou,
						; uma vez por cada tecla carregada
							
tecla_continua:
	LOCK 0				; LOCK para o teclado comunicar aos restantes processos que tecla detetou,
						; enquanto a tecla estiver carregada


; *****************************************************************************
; *                            Design dos objetos                             * 
; *****************************************************************************

; Tabelas que definem o desenho do asteróide nas suas várias fases
DEF_ASTEROIDE_1:					
	WORD		LARGURA_OBJETO_1, ALTURA_OBJETO_1
	WORD		COR_ASTEROIDE_INICIAL

DEF_ASTEROIDE_2:
	WORD		LARGURA_OBJETO_2, ALTURA_OBJETO_2
	WORD		COR_ASTEROIDE_INICIAL, COR_ASTEROIDE_INICIAL
    WORD        COR_ASTEROIDE_INICIAL, COR_ASTEROIDE_INICIAL
     
DEF_ASTEROIDE_3:
	WORD		LARGURA_OBJETO_3, ALTURA_OBJETO_3
	WORD		0,COR_ASTEROIDE,0
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        0,COR_ASTEROIDE,0

DEF_ASTEROIDE_4:
    WORD		LARGURA_OBJETO_4, ALTURA_OBJETO_4
	WORD		0,COR_ASTEROIDE,COR_ASTEROIDE,0
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        0,COR_ASTEROIDE,COR_ASTEROIDE,0

DEF_ASTEROIDE_5:
    WORD		LARGURA_OBJETO_5, ALTURA_OBJETO_5
	WORD		0,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,0
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE
    WORD        0,COR_ASTEROIDE,COR_ASTEROIDE,COR_ASTEROIDE,0

; Tabelas que definem o desenho da nave inimiga nas suas várias fases
DEF_NAVE_INIMIGA_1:		
	WORD		LARGURA_OBJETO_1, ALTURA_OBJETO_1
	WORD		COR_NAVE_INICIAL

DEF_NAVE_INIMIGA_2:
	WORD		LARGURA_OBJETO_2, ALTURA_OBJETO_2
	WORD		COR_NAVE_INICIAL, 0
    WORD        0, COR_NAVE_INICIAL
     
DEF_NAVE_INIMIGA_3:
	WORD		LARGURA_OBJETO_3, ALTURA_OBJETO_3
	WORD		COR_NAVE_INIMIGA, 0, COR_NAVE_INIMIGA
    WORD        0, COR_NAVE_INIMIGA, 0
    WORD        COR_NAVE_INIMIGA, 0, COR_NAVE_INIMIGA

DEF_NAVE_INIMIGA_4:
    WORD		LARGURA_OBJETO_4, ALTURA_OBJETO_4
	WORD		0, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, 0
    WORD        COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA
    WORD        0, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, 0
    WORD        COR_NAVE_INIMIGA, 0, 0, COR_NAVE_INIMIGA

DEF_NAVE_INIMIGA_5:
    WORD		LARGURA_OBJETO_5, ALTURA_OBJETO_5
	WORD		COR_NAVE_INIMIGA, 0, 0, 0, COR_NAVE_INIMIGA
    WORD        COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA
    WORD        0, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, 0
    WORD        COR_NAVE_INIMIGA, COR_NAVE_INIMIGA, 0, COR_NAVE_INIMIGA, COR_NAVE_INIMIGA
    WORD        COR_NAVE_INIMIGA, 0, 0, 0, COR_NAVE_INIMIGA


; Tabela que define o desenho da explosão
DEF_EXPLOSAO:
	WORD		LARGURA_OBJETO_5,ALTURA_OBJETO_5
	WORD		0,COR_EXPLOSAO,0,COR_EXPLOSAO,0
	WORD		COR_EXPLOSAO,0,COR_EXPLOSAO,0,COR_EXPLOSAO
	WORD		0,COR_EXPLOSAO,0,COR_EXPLOSAO,0
	WORD		COR_EXPLOSAO,0,COR_EXPLOSAO,0,COR_EXPLOSAO
	WORD		0,COR_EXPLOSAO,0,COR_EXPLOSAO,0

; Tabela que define o desenho do rover
DEF_NAVE:					
	WORD		LARGURA_NAVE, ALTURA_NAVE
	WORD		0,0,COR_NAVE,0,0
	WORD		0,COR_NAVE,COR_NAVE,COR_NAVE,0		
	WORD		COR_NAVE,COR_NAVE,0,COR_NAVE,COR_NAVE		
	WORD		COR_NAVE,0,0,0,COR_NAVE	

; *****************************************************************************
; *                             Início do código                              *
; *****************************************************************************

PLACE   0

inicio:
	MOV  SP, SP_inicial		; inicializa SP
	MOV  BTE, interrupcoes  ; inicializa BTE
    MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado
    MOV  [APAGA_ECRÃ], R1	; apaga todos os pixels já desenhados
	MOV  [APAGA_CENARIO_FRONTAL], R1 ; apaga o cenário frontal
	MOV	 R1, IMAGEM_INICIO				; cenário de fundo número 0
    MOV  [SELECIONA_CENARIO_FUNDO], R1	; seleciona o cenário de fundo

	EI0						; interrupção meteoro
	EI1						; interrupção míssil
	EI2						; interrupção display
	EI						; interrupção geral

; chamar os processos
	CALL controlo
	CALL nave

; Loop para criar as quatro instâncias do processo meteoro
	MOV  R7, N_METEOROS			
ciclo_call_meteoro:
	SUB  R7, 1 					; indice da instância
	CALL meteoro
	CMP  R7, 0 					; já criou as instâncias todas?
	JNZ  ciclo_call_meteoro		; se não, continua a criar

; chamar os restantes processos
	CALL display
	CALL teclado
	CALL missil

	MOV  R0, [lock_main]		; para impedir o programa de continuar a executar código para baixo



; *****************************************************************************
; *                            PROCESSO - CONTROLO                            *
; *            																  *
; *  Descrição - controla o modo de jogo                                      *
; *  modo_jogo - estado do jogo: 											  *
; *   -> 0 - início 														  *
; *   -> 1 - in-game 														  *
; *   -> 2 - pausa                                                            *
; *   -> 3 - terminado 														  *
; *****************************************************************************

PROCESS SP_CONTROLO

controlo:		
	MOV  SP, SP_CONTROLO		   ; inicializa o stack pointer do controlo
	MOV  R0, MODO_INICIO					   
	MOV  [modo_jogo], R0           ; modo de jogo 0: início
ciclo_controlo:
	MOV  R1, [tecla_carregada]     ; aguarda que seja premida uma tecla
	MOV  R5, TECLA_C
	CMP  R1, R5 			  	   ; ver se é a tecla C
	JZ   comecar_jogo
	MOV  R5, TECLA_D
	CMP  R1, R5 			  	   ; ver se é a tecla D
	JZ   pausar_ou_retomar	
	MOV  R5, TECLA_E
	CMP  R1, R5  			  	   ; ver se é a tecla E
	JZ   call_terminar_jogo
	JMP  ciclo_controlo            ; tecla não interessa


comecar_jogo:
	MOV  R0, [modo_jogo] 				; ler o modo de jogo
	CMP  R0, MODO_INICIO                ; ver se está no estado inicial
	JNZ  recomecar_jogo  				; caso não esteja, verifica se o jogo está terminado
	MOV	 R3, IMAGEM_JOGO				; cenário de fundo número 1
    MOV  [SELECIONA_CENARIO_FUNDO], R3	; seleciona o cenário de fundo
	MOV  [modo_jogo], R3 				; atualizar o modo de jogo para ativo	
	MOV  [lock_jogo], R3 				; o valor de R3 não importa
	MOV  R3, MUSICA_FUNDO				; seleciona a música
	MOV  [TOCA_SOM_LOOP], R3			; toca uma música de fundo em loop
	EI
	JMP  ciclo_controlo


recomecar_jogo:
	CMP  R0, MODO_FIM 					; ver se o jogo está terminado
	JNZ  ciclo_controlo
	MOV  R0, MODO_INICIO 				; estado inicial
	MOV  [modo_jogo], R0  				; atualiza o modo de jogo para inicial
	MOV  [lock_jogo], R3 				; o valor de R3 não importa
	MOV  [rover_explodiu], R0			; reseta a variável
	MOV  [APAGA_CENARIO_FRONTAL], R3    ; apaga o cenário frontal
	MOV	 R3, IMAGEM_INICIO				; guarda o cenário de fundo número 0
    MOV  [SELECIONA_CENARIO_FUNDO], R3	; seleciona o cenário de fundo
	MOV  R7, ENERGIA_MAXIMA 			; dar reset ao display, visto que devido
	MOV  [contador_display], R7 		; à baixa frequência da sua interrupção,
	MOV  R7, VALOR_DISPLAY_MAX			; é possível terminar e recomeçar o jogo 
	MOV  [DISPLAYS], R7 				; sem que o processo dê por isso
	JMP  ciclo_controlo	

pausar_ou_retomar:
	MOV  R0, [modo_jogo] 				; ler o modo de jogo
	CMP  R0, MODO_ATIVO 				; ver se está no modo ativo
	JZ   pausar 
	CMP  R0, MODO_PAUSA 				; ver se está no modo de pausa
	JZ   retomar
	JMP  ciclo_controlo	  				; caso não esteja em nenhum dos 2, não faz nada

pausar:
	DI 									; pausa o funcionamento normal
	MOV  R3, IMAGEM_PAUSA 				; cenário número 2
	MOV  [SELECIONA_CENARIO_FRONTAL], R3 ; seleciona cenário frontal
	MOV  [modo_jogo], R3 				; atualiza o modo de jogo para pausa
	MOV  R3, MUSICA_FUNDO				; seleciona a música de fundo
	MOV  [PAUSA_SOM], R3 				; pausa-a
	JMP  ciclo_controlo

retomar:
	MOV  [APAGA_CENARIO_FRONTAL], R3    ; apagar cenário frontal
	MOV  R3, MODO_ATIVO 				; modo ativo
	MOV  [modo_jogo], R3 				; atualiza o modo de jogo para ativo
	MOV  [lock_jogo], R3 				; valor de R3 não interessa
	MOV  R3, MUSICA_FUNDO				; seleciona a música de fundo
	MOV  [RETOMA_SOM], R3 				; retoma-a
	EI 									; retomar comportamento normal do programa
	JMP  ciclo_controlo

call_terminar_jogo:
	MOV  R3, MODO_ATIVO
	MOV  [fim_tecla_E], R3 				; o fim do jogo foi forçado ao clicar na tecla E
	CALL terminar_jogo
	JMP  ciclo_controlo


; *****************************************************************************
; *                                  ROTINA                                   *
; * terminar_jogo - termina o jogo, alterando o ecrã para o cenário de fundo  *
; * de fim de jogo                                                            *
; *                                                                           *
; *****************************************************************************

terminar_jogo:
	PUSH R0
	PUSH R3
	MOV  R0, [modo_jogo]					; guarda o valor do modo de jogo 
	CMP  R0, MODO_INICIO					; se ainda não tiver começado,
	JZ   exit_terminar_jogo					; não pode acabar
	CMP  R0, MODO_FIM 						; se já tiver terminado, sai
	JZ   exit_terminar_jogo
	DI										; não se quer que mais nada ocorra
	MOV  [APAGA_ECRÃ], R0              	 	; apagar ecrãs (conteúdo de R0 irrelevante)
	MOV  R0, MODO_FIM						; modo de jogo 3 - fim
	MOV  [modo_jogo], R0 					; atualizar o valor do modo de jogo
	MOV  [tecla_continua], R0 				; dar unlock no processo da nave para que fique
											; lock em "lock_jogo", e consiga detetar o reinício do jogo
	MOV  R0, [fim_tecla_E] 
	CMP  R0, 1 								; fim do jogo por se clicar na tecla E?
	JZ   seleciona_fundo_tecla				; seleciona ecrã de game over por tecla
	MOV  R0, [rover_explodiu]					
	CMP  R0, 1								; rover explodiu?
	JZ   seleciona_fundo_colisao			; seleciona ecrã de game over por colisão
	MOV  R3, IMAGEM_FIM_ENERGIA				; se não foi por colisão ou tecla, foi por falta de energia; guarda a imagem
	JMP  mostra_imagem				        ; já selecionou a imagem: mostra-a
seleciona_fundo_tecla:
	MOV  R3, IMAGEM_FIM_TECLA  				; guarda o cenário de fundo 3
	JMP  mostra_imagem
seleciona_fundo_colisao:
	MOV  R3, IMAGEM_FIM_COLISAO 			; guarda o cenário de fundo 5
mostra_imagem:
	MOV  [SELECIONA_CENARIO_FRONTAL], R3	; selecionar cenário de fundo
exit_terminar_jogo:
	MOV  R3, 0
	MOV  [fim_tecla_E], R3 					; resetar a variável
	MOV  R3, MUSICA_FUNDO					; seleciona a música de fundo
	MOV  [TERMINA_SOM], R3 				    ; pára de a tocar
	POP  R3
	POP  R0
	RET

	
; *****************************************************************************
; *                            PROCESSO - NAVE                                *
; *            																  *
; *  Descrição - gere o movimento da nave                                     *
; *  R1 - linha da nave                                                       *
; *  R2 - coluna da nave                                                      *
; *  R3 - endereço da tabela que define a nave						          *
; *  R11 - valor do atraso											          * 
; *****************************************************************************

PROCESS SP_NAVE

nave:
	EI
	MOV  SP, SP_NAVE			; inicializa stack pointer do processo da nave
    MOV  R1, LINHA_NAVE			; linha da nave
    MOV  R2, COLUNA_NAVE		; coluna da nave
	MOV	 R3, DEF_NAVE		    ; endereço da tabela que define a nave
	MOV  [pos_nave_colunas], R2 ; reset à coluna em memória
	MOV  R11, ATRASO 			; valor do atraso
	MOV  R10, [modo_jogo]       ; verificar se o jogo está ativo
	CMP  R10, MODO_ATIVO 		; modo ativo = 1
	JZ 	 mostra_nave 			; caso esteja faz o percurso normal
	MOV  R4, [lock_jogo] 		; caso não, fica locked
mostra_nave:
	MOV  R0, ECRA_NAVE			; selecionar o ecrã
	MOV  [SELECIONA_ECRA], R0   ; exibe o ecrã
	CALL desenha_boneco			; desenha a nave a partir da tabela
espera_tecla_nave:
	MOV  R0, [tecla_continua]   ; lê o LOCK e bloqueia até o teclado escrever nele novamente
nave_ativo: 					; verificar se o jogo está ativo
	MOV  R10, [modo_jogo]             
	CMP  R10, MODO_ATIVO 		; modo ativo = 1
	JZ 	 movimenta_nave			; caso esteja faz o percurso normal
	MOV  R4, [lock_jogo] 		; caso não, fica locked
	MOV  R10, [modo_jogo]
	CMP  R10, MODO_INICIO		; é para reiniciar o jogo?
	JZ   nave					; reinicia o processo
movimenta_nave:
	CMP  R0, TECLA_0  			; ver se é a tecla 0
	JZ   mover_rover_esq 		; movimentar rover para a esquerda
	CMP  R0, TECLA_2 			; ver se é a tecla 2
	JZ   mover_rover_dir 		; movimentar rover para a direita
	JMP  espera_tecla_nave      ; aguarda por novo clique

; *****************************************************************************
; * mover_rover_dir - move, se possível, o rover um píxel para a direita      *
; * Argumentos:	R2 - coluna do boneco                                         *
; *				R3 - definição do boneco                                      *
; *                                                                           *
; *****************************************************************************

mover_rover_dir:
	MOV R5, MAX_COLUNA				  ; guarda coluna máxima (limite direita)
	MOV R6, [R3]        	          ; obtém largura
; testar limite direito
	ADD R6, R2		
	CMP R5, R6				          ; vê se ultrapassa o limite
	JLT exit_right					  ; se sim, não se move
; redesenhar boneco
	PUSH R0
	MOV  R0, ECRA_NAVE				  ; selecionar o ecrã
	MOV  [SELECIONA_ECRA], R0
	POP  R0
	CALL apaga_boneco
	ADD  R2, 1 						  ; avançar a nave para a direita 1 píxel
	MOV  [pos_nave_colunas], R2		  ; atualiza a posição das colunas em memória
	CALL assinala_verificar_colisoes  ; assinalar que é para verificar colisões
	MOV  [int_meteoros], R2        	  ; desbloquear os meteoros
	CALL desenha_boneco				  ; desenha a nave na nova posição
ciclo_atraso_right:
	CALL atraso						  ; atraso modifica R11, onde se guarda o valor do atraso
	CMP  R11, 0						  ; é zero?	
	JZ   exit_right					  ; se sim, pode-se movimentar outra vez
	YIELD              				  ; para não bloquear os outros processos e fazer 1 iteração de cada vez
	JMP ciclo_atraso_right			  ; enquanto o atraso não for zero, não se movimenta
exit_right:
	JMP espera_tecla_nave


; *****************************************************************************
; * mover_rover_esq - move, se possível, o rover um píxel para a esquerda     *
; * Argumentos:	R2 - coluna do boneco                                         *
; *				R3 - definição do boneco                                      *
; *																			  *
; *****************************************************************************

mover_rover_esq: 						 
	MOV R5, MIN_COLUNA					; limite máximo esquerdo
; testar limite esquerdo
	CMP R2, R5 		 					; verifica se o boneco está dentro do limite esquerdo
	JZ exit_left						; se sim, para de mover
; redesenhar boneco		
	PUSH R0						
	MOV  R0, ECRA_NAVE	 				; selecionar o ecrã
	MOV  [SELECIONA_ECRA], R0	
	POP  R0
	CALL apaga_boneco 		 
	ADD  R2, -1 						; avançar a nave para a esquerda
	MOV  [pos_nave_colunas], R2
	CALL assinala_verificar_colisoes    ; assinalar que é para verificar colisões
	MOV  [int_meteoros], R2             ; desbloquear os meteoros
	CALL desenha_boneco
ciclo_atraso_left:
	CALL atraso
	CMP  R11, 0
	JZ   exit_left
	YIELD              					; para não bloquear os outros processos e fazer 1 iteração de cada vez
	JMP ciclo_atraso_left
exit_left:
	JMP espera_tecla_nave


; *****************************************************************************
; *                            PROCESSO - DISPLAY                             *
; * 									      								  *
; * Descrição - Controla o valor do display				                      *
; * R7 - valor da energia do rover											  *
; * R8 - endereço dos displays												  *
; *****************************************************************************


PROCESS SP_DISPLAY
	
display: 							; inicializações
	EI
	MOV  SP, SP_DISPLAY
	MOV  R7, ENERGIA_MAXIMA			; valor da energia
	MOV  [contador_display], R7		; reseta o contador
	CALL converte_decimal			; o display apresenta 100H (para simular 100d)
    MOV  [DISPLAYS], R9  			; reseta os displays para 100
	MOV  R8, DISPLAYS				; endereço dos displays
espera_int_display:
	MOV  R0, [int_displays]  		; lê o LOCK e bloqueia até a interrupção ocorrer novamente
display_ativo: 						; verifica se o jogo está ativo
	MOV  R10, [modo_jogo]       
	CMP  R10, MODO_ATIVO 			; modo ativo = 1
	JZ   decrementa_display			; caso esteja ativo, altera e exibe o valor 
	MOV  R4, [lock_jogo] 			; caso não, fica locked
	MOV  R10, [modo_jogo]
	CMP  R10, MODO_INICIO 			; é para reiniciar o jogo?
	JZ   display					; reinicia o processo	
decrementa_display:
	MOV  R7, [contador_display]		; guarda o valor da energia
	MOV  R0, -5				     	; valor a decrementar no altera_valor_display
    CALL altera_valor_display		; altera e exibe o display
	JMP  espera_int_display			; volta a esperar por uma interrupção


; *****************************************************************************
; *                                  ROTINA                                   *
; * converte_decimal - converte o número decimal em R7 de forma a, nos        *
; * displays hexadecimais, aparecerem os dígitos decimais                     *
; * Argumentos:	R7 - número a coverter                                        *
; *                                                                           *
; * Retorna:    R9 - número convertido                                        * 
; *****************************************************************************

converte_decimal:
    PUSH R1
    PUSH R2
    PUSH R3
	PUSH R7
	MOV  R1, 100    	; para comparar
	CMP  R7, R1			; se o número a converter for 100, 
	JZ  converte_cem  	; converte-se à parte, por questão de eficiência
    MOV  R1, 1000    	; fator
    MOV  R2, 10      	; para ir decrementando o fator
    MOV  R3, 0       	; dígito
    MOV  R9, 0       	; resultado
	JMP  ciclo_dec	
converte_cem:			; se for para converter 100, faz isso à parte, por questão de eficiência
	MOV  R9, VALOR_DISPLAY_MAX ; 100H (para simular 100 decimal)
	JMP exit_dec	 	; já converteu - sai
ciclo_dec:    
    MOD  R7, R1      	; 1. vai reduzindo o valor a converter
    DIV  R1, R2     	; 2. reduz o fator
    CMP  R1, 0      	; o fator de divisão chegou a zero?
    JZ exit_dec     	; se sim, sai
    MOV  R3, R7     	; guarda o número depois do MOD fator para obter dígito
    DIV  R3, R1     	; 3. obtém o dígito
    SHL  R9, 4      	; 4. dá espaço para o dígito
    OR   R9, R3     	; 5. adiciona o dígito ao resultado
    CMP  R7, 0      	; o número a converter chegou a zero?
    JNZ ciclo_dec   	; se não, repete o ciclo
exit_dec:
	POP  R7
    POP  R3
    POP  R2
    POP  R1
	RET


; *****************************************************************************
; *                                  ROTINA                                   *
; * altera_valor_display - recebe no registo R0 o valor a alterar ao          *
; * contador, calcula o novo valor e altera-o na variável do contador.        *
; * Argumento:	R0 - valor a adicionar (positivo ou negativo) ao contador     *
; *             contador_display - valor do contador                          *
; *                                                                           *
; * - Altera o valor da variável do contador                                  *
; * - Converte-o para decimal                                                 *
; * - Exibe o novo valor nos displays                                         * 
; *****************************************************************************

altera_valor_display:
	PUSH R8			
	PUSH R7	
	PUSH R6			
	MOV  R8, DISPLAYS			 ; endereço do display
	MOV  R7, [contador_display]  ; guarda o valor da energia
	ADD  R7, R0                  ; adiciona o valor 
	CMP  R7, 0                   ; chegou a zero? 
	JLE  chama_terminar_jogo	 ; se sim, termina o jogo
	MOV  R6, ENERGIA_MAXIMA					
	CMP  R7, R6				     ; vai ser maior que 100? 
	JGE  forca_cem				 ; se sim, o valor da energia volta a 100
	JMP  exit_altera_display	 ; não queremos terminar o jogo 
chama_terminar_jogo:
	MOV  R9, 0					 ; força-se o valor do display a zero
	CALL terminar_jogo			 ; o jogo acabou
	MOV  R6, SEM_ENERGIA
	MOV  [TOCA_SOM], R6 		 ; toca o som de ficar sem energia
	JMP  exit_altera_display
forca_cem:
	MOV  R7, ENERGIA_MAXIMA		 ; coloca 100 no registo a converter em decimal e no valor da energia
exit_altera_display:
	CALL converte_decimal		 ; converte o valor fornecido em R7 para decimal
	MOV  [R8], R9				 ; apresenta-o no display 
	MOV  [contador_display], R7  ; atualiza o valor do contador
	POP  R6
	POP  R7
	POP  R8
	RET 



; *****************************************************************************
; *                            PROCESSO - MISSIL                              *
; *            																  *
; *  Descrição - gere o movimento do missil                                   *
; *  R1 - linha do míssil						          					  *	
; *  R2 - coluna do míssil						         					  *
; *  R3 - quantidade de movimentos restantes do míssil						  *
; *****************************************************************************

PROCESS SP_MISSIL

missil:
	EI
	MOV  SP, SP_MISSIL				; inicializa stack pointer do processo míssil
	MOV  R10, [modo_jogo]       	; verificar se o jogo está ativo
	CMP  R10, MODO_ATIVO 			; modo ativo = 1
	JZ 	 espera_tecla_missil		; caso esteja faz o percurso normal
	MOV  R4, [lock_jogo] 			; caso não, fica locked
espera_tecla_missil:
	MOV  R0, [tecla_carregada]   	; lê o LOCK e bloqueia até o teclado escrever nele novamente

missil_ativo:
	MOV  R10, [modo_jogo]
	CMP  R10, MODO_ATIVO 			; modo ativo = 1
	JZ   verifica_tecla_missil      ; se tiver ativo, faz o percurso normal
	MOV  R9, [lock_jogo]			; senão, fica locked
	MOV  R10, [modo_jogo]
	CMP  R10, MODO_INICIO 			; é para reiniciar o jogo?
	JZ   missil 			  		; reinicia o processo

verifica_tecla_missil:
	CMP  R0, TECLA_1  				; ver se é a tecla 1
	JNZ  espera_tecla_missil        ; se não for, aguarda por novo clique
									; se for a tecla 1, spawna um míssil
spawn_missil:
	MOV  R1, LINHA_MISSIL_INICIAL   ; linha do missil
	MOV  R2, [pos_nave_colunas]     ; coluna do missil
	ADD  R2, 2					    ; centro da nave
	MOV  [pos_missil_linhas], R1    ; atualizar linha do missil na memória
	MOV  [pos_missil_colunas], R2   ; atualizar coluna do missil na memória
	MOV  R3, MOVIMENTOS_MISSIL		; nº movimentos que o missil vai realizar
	MOV  R0, -5						; decrementa em 5 a energia do rover
	CALL altera_valor_display		; chama a rotina para atualizar o display
	MOV  R0, [modo_jogo]			
	CMP  R0, MODO_FIM 				; ver se, ao disparar o missil, o jogo terminou por falta de energia
	JZ   end_missil					; se sim, apaga o míssil
mostra_missil:
	MOV  R0, ECRA_NAVE        		; selecionar o ecrã
	MOV  [SELECIONA_ECRA], R0		
	MOV  R0, DISPARO				; seleciona som de disparo
    MOV  [TOCA_SOM], R0             ; tocar som de disparo
	CALL desenha_missil				

espera_mov_missil:
	MOV  R8, [int_missil]      		; lê o LOCK e bloqueia até a interrupção ocorrer novamente

mov_missil_ativo: 				   	; verificar se o jogo está ativo
	MOV  R10, [modo_jogo]             
	CMP  R10, MODO_ATIVO 			; modo ativo = 1
	JZ 	 posição_missil	   			; caso esteja faz o percurso normal
	MOV  R9, [lock_jogo] 		   	; caso não, fica locked
	MOV  R10, [modo_jogo]
	CMP  R10, MODO_INICIO 			; é para reiniciar o jogo?
	JZ   end_missil	    			; reinicia o processo

posição_missil:
	SUB  R3, 1						; nº movimentos do missil
	CMP  R3, 0					 	; já não pode fazer mais?	
	JZ   end_missil					; se não, apaga-o
	CALL apaga_missil
	MOV  R9, [apagar_missil] 		; ver se o missil colidiu e tem de ser apagado
	CMP  R9, 1						; 1 - colidiu
	JZ   end_missil
	SUB  R1, 1 						; linha acima
	CALL desenha_missil				; desenha o míssil na linha acima
	MOV  [pos_missil_linhas], R1 	; atualiza a posição do missil em memória
	CALL assinala_verificar_colisoes ; assinalar que é para verificar colisões
	MOV  [int_meteoros], R0         ; desbloquear os meteoros
	JMP  espera_mov_missil
	
end_missil:
	CALL apaga_missil
	MOV  R8, 0 						; registo para resetar variáveis
	MOV  [pos_missil_linhas], R8	; reseta a posição das linhas do míssil
	MOV  [pos_missil_colunas], R8   ; reseta a posição das colunas do míssil 
	MOV  [apagar_missil], R8 		; resetar a variável
	JMP  missil		
	 
; Rotina desenha_missil
desenha_missil:
	MOV  R4, COR_MISSIL				; seleciona a cor do píxel, cinza
	MOV  [SELECIONA_ECRA], R0		; seleciona o ecrã do míssil
	CALL escreve_pixel
	RET

; Rotina apaga_missil
apaga_missil:
	MOV  R4, 0						; seleciona a cor do píxel, branco
	MOV  [SELECIONA_ECRA], R0		; seleciona o ecrã
	CALL escreve_pixel
	RET
	

; *****************************************************************************
; *                                  ROTINA                                   *
; * assinala_verificar_colisoes - recebe no registo R0 o valor a alterar ao   *
; * contador, calcula o novo valor e altera-o na variável do contador.        *
; * Argumento:	R0 - valor a adicionar (positivo ou negativo) ao contador     *
; *             contador_display - valor do contador                          *
; *                                                                           *
; * - Altera o valor da variável do contador                                  *
; * - Converte-o para decimal                                                 *
; * - Exibe o novo valor nos displays                                         * 
; *****************************************************************************

assinala_verificar_colisoes:
	PUSH R0
	PUSH R1
	PUSH R2
	MOV  R1, N_METEOROS				; nº de instâncias do processo meteoro (4)
	MOV  R0, verificar_colisoes		; tabela das variáveis
	MOV  R2, 1 						; valor a escrever nas variáveis
ciclo_assinala_verificar_colisoes:
	SUB  R1, 1						; menos uma instância a verificar
	MOV  [R0], R2					; escreve na variável
	ADD  R0, 2 						; próxima variável (WORD)
	CMP  R1, 0						; acabou?
	JNZ  ciclo_assinala_verificar_colisoes 
exit_assinala_verificar_colisoes:
	POP  R2
	POP  R1
	POP  R0
	RET

; *****************************************************************************
; *                            PROCESSO - METEORO                             *
; *            																  *
; *  Descrição - gere o movimento do meteoro     						      *
; *  R1 - linha do meteoro                                                    *
; *  R2 - coluna do meteoro                                                   *
; *  R3 - tabela com o desenho do meteoro                                     *
; *  R7 - número da instância do processo (0,1,2,3)                           *
; *  R8 - contador dos movimentos do meteoro                                  *
; *  R9 - identifica se é um asteróide ou nave inimiga                        *
; *  R10 - número da instância * 2 (para aceder às variáveis)                 *
; *****************************************************************************

PROCESS SP_METEORO_0

meteoro:
	EI
	MOV  R0, TAB_SP_METEOROS	    ; tabela dos stack pointers dos meteoros
	MOV  R10, R7 				    ; cópia da instância do processo
	SHL  R10, 1 				    ; multiplica por 2 pois vai-se aceder a WORDs 
	MOV  SP, [R0+R10] 			    ; inicializar com o SP correspondente
reset_alturas: 					    ; colocar as alturas padrão para os meteoros
	MOV  R1, ALTURA_OBJETO_5 	    ; de tamanho 5, pois estas são alteradas
	MOV  R2, altura_meteoros	    ; tabela de alturas dos meteoros
	MOV  [R2+R10], R1 			    ; resetar a variável de altura da sua instância
gera_meteoro:
	CALL coluna_aleatoria 		    ; coloca em R4 um dos valores: [1,9,17,25,33,41,49,57]
	MOV  R1, LINHA_METEORO          ; linha do meteoro
	MOV  R2, R4      			    ; coluna do meteoro
	;CALL asteroide_ou_nave   	    ; coloca em R9 o valor ASTEROIDE ou NAVE
	;CMP  R9, ASTEROIDE 			    ; ver se é um asteróide
	JMP   set_asteroide 			    ; caso não seja, é uma nave
	MOV  R3, DEF_NAVE_INIMIGA_1     ; endereço da tabela que define a nave
	JMP  inicio_meteoro
set_asteroide:
	MOV  R3, DEF_ASTEROIDE_1        ; endereço da tabela que define o asteroide
inicio_meteoro:
	MOV  R5, MAX_LINHA              ; guarda a linha final	
	MOV  R8, 0 					    ; contador meteoro
	MOV  R0, [modo_jogo]            ; verificar se o jogo está ativo
	CMP  R0, 1 				   	    ; modo ativo = 1
	JZ 	 atraso_meteoro 		    ; caso esteja faz o percurso normal
	MOV  R0, [lock_jogo] 		    ; caso não, fica locked

atraso_meteoro:
	MOV  R0, atrasos_meteoros	    ; tabela com os atrasos de cada instância de meteoro
	MOV  R11, [R0+R10] 			    ; vai buscar à tabela o nº de interrupções que tem que ficar à espera
ciclo_atraso_meteoro:
	MOV  R0, [int_missil] 		    ; fica locked na interrupção
	SUB  R11, 1
	JNZ  ciclo_atraso_meteoro 
	JMP  meteoro_ativo 			    ; vai diretamente para meteoro_ativo para conseguir
								    ; detetar se o jogo está em pausa ou terminado
								    ; ao sair deste ciclo

espera_mov_meteoro:
	MOV  R0, [int_meteoros]         ; lê o LOCK e bloqueia até a interrupção ocorrer novamente

meteoro_ativo: 				        ; verificar se o jogo está ativo
	MOV  R0, [modo_jogo]             
	CMP  R0, MODO_ATIVO 		    ; modo ativo = 1
	JZ 	 deteta_colisoes_start	    ; caso esteja faz o percurso normal
	MOV  R0, [lock_jogo] 		    ; caso não, fica locked
	MOV  R0, [modo_jogo]
	CMP  R0, MODO_INICIO 		    ; é para reiniciar o jogo?
	JZ   reset_alturas			    ; reinicia o processo	

deteta_colisoes_start:
	MOV  R0, verificar_colisoes		; tabela com variáveis que assinalam a necessidade de verificar as colisões
	MOV  R6, [R0+R10] 				; aceder à variável correspondente
	CMP  R6, 1						; é para verificar colisão?
	JNZ  posicao_meteoro			; se não for, mexe o meteoro normalmente
	MOV  R6, NAO_COLIDIU			; vai verificar colisões, logo
	MOV  [R0+R10], R6				; reseta a variável desta instância
	CALL deteta_colisoes
	MOV  R6, [ha_colisao]			; vê se ocorreu colisão e de que tipo
	CMP  R6, NAO_COLIDIU			; não colidiu?
	JZ   espera_mov_meteoro			; se não, aguarda um próximo evento
	CMP  R6, COLIDIU_MISSIL			; colidiu com um míssil?
	JZ   colide_missil				
	JMP  colide_nave				; se colidiu, e não colidiu com um míssil, colidiu com uma nave
	
posicao_meteoro:
	PUSH R4
	MOV  R4, altura_meteoros	   ; tabela da altura dos meteoros
	MOV  R6, [R4+R10]              ; obtém a altura do meteoro
	CMP  R6, 0 				       ; ver se a altura já chegou a 0
	POP  R4
	JZ   novo_meteoro 			   ; caso sim, cria um novo
   
desenha_meteoro:
    ADD   R8, 1 				   ; incrementa contador do meteoro
	MOV   [SELECIONA_ECRA], R7	   ; seleciona o ecrã
	CALL  apaga_boneco			   
    CALL  muda_animacao			   ; atualiza o desenho do meteoro 
	ADD   R6, R1                   ; adiciona-se a linha (R1) à altura do meteoro (R6)
	CMP   R6, R5                   ; vê se meteoro chegou ao final
	JLE   deteta_colisoes_meteoro  ; caso não, verifica colisões
	; Se o meteoro chegou ao final, ignora o jump e reduz a altura

reduz_altura:
	PUSH R4
	PUSH R1
	MOV  R4, altura_meteoros	    ; label da tabela de alturas dos meteoros
	ADD  R3, 2                      ; add 2 para ler a altura na tabela do desenho do meteoro
	MOV  R1, [R4+R10] 			    ; cópia da altura desta instância do meteoro
	SUB  R1, 1					    ; reduz a altura em 1
	MOV  [R3], R1                   ; atualiza a altura na tabela do meteoro de tamanho 5
	SUB  R3, 2					    ; volta para o início da tabela do desenho do meteoro
	MOV  [R4+R10], R1 			    ; atualizar a variável da altura em memória
	POP  R1
	POP  R4
	

deteta_colisoes_meteoro:
	CALL deteta_colisoes			; vê se existiram colisões, escrevendo em ha_colisao
	MOV  R6, [ha_colisao]			; guarda o valor de ha_colisao
	CMP  R6, NAO_COLIDIU			; não colidiu?
	JZ   linha_seguinte				; se não, desenha o meteoro na linha seguinte
	CMP  R6, COLIDIU_MISSIL			; se sim, vê se foi com um míssil
	JZ   colide_missil				
	JMP  colide_nave				; se não foi com um míssil, foi com uma nave


linha_seguinte:
	ADD	  R1, 1			    	; para desenhar objeto na linha seguinte (abaixo)
	CALL  desenha_boneco
	MOV   R6, 15 				; compara-se com 15 uma vez que é o valor mínimo do 
	CMP   R8, R6 				; contador R8 para o meteoro ter tamanho 5x5,
	JLE   espera_mov_meteoro 	; fase a partir da qual queremos resetar a altura
	ADD   R3, 2 				; add 2 para ler a altura
	MOV   R6, ALTURA_OBJETO_5
	MOV   [R3], R6 				; voltar a pôr a altura inicial na tabela do meteoro para não alterar os outros
	SUB   R3, 2					; volta ao início da tabela do desenho
	JMP   espera_mov_meteoro

colide_nave:
    MOV  R6, NAO_COLIDIU		 
    MOV  [ha_colisao], R6		; reseta a variável
	CALL houve_colisao_nave 	; atualizar valor da energia (ou termina jogo)
	MOV  R6, [rover_explodiu]   ; ver se o rover colidiu (se o jogo terminou)
	CMP  R6, 1					; rover colidiu com uma nave?
	JZ   colisao_nave_inimiga	; caso tenha colidido, toca o som de explosão e termina o jogo
	MOV  R6, APANHA_METEORO		; senão, colidiu com um meteoro
	MOV  [TOCA_SOM], R6 		; tocar som de apanhar meteoro
	JMP  novo_meteoro			; cria um novo meteoro

colisao_nave_inimiga:			
	MOV  R6, EXPLOSAO_ROVER			
	MOV  [TOCA_SOM], R6 		; toca o som de explosão com o rover
	JMP  espera_mov_meteoro		; vai reiniciar o jogo


colide_missil:
    MOV  R6, NAO_COLIDIU
    MOV  [ha_colisao], R6		; reseta a variável
	MOV  R6, EXPLOSAO			
	MOV  [TOCA_SOM], R6 		; toca o som de explosão
	CALL houve_colisao_missil   ; atualizar valor da energia
	MOV  [apagar_missil], R6 	; avisar que se tem que apagar o missil
explosao:						; se colidiu com um míssil, desenha a explosão
	MOV  [SELECIONA_ECRA], R7
	MOV  R3, DEF_EXPLOSAO		; guarda a tabela que define o design da explosão
	CALL desenha_boneco			; desenha a explosão
	MOV  R0, [int_missil] 		; aguarda três ciclos do relógio dos mísseis
	MOV  R0, [int_missil] 		; para desenhar a animação
	MOV  R0, [int_missil] 		; da explosão
explosao_ativo:					; vê se o jogo está ativo aquando do fim da explosão
	MOV  R0, [modo_jogo]
	CMP  R0, MODO_ATIVO 		; modo ativo
	JZ   novo_meteoro 			; caso esteja ativo, apaga a explosão e gera um novo meteoro
	MOV  R0, [lock_jogo] 		; fica bloqueado
	MOV  R0, [modo_jogo]  		
	CMP  R0, MODO_INICIO 		; é para reiniciar?
	JNZ  novo_meteoro 			; caso não, faz o percurso normal
	MOV  [SELECIONA_ECRA], R7
	CALl apaga_boneco
	JMP  reset_alturas
novo_meteoro:
	MOV   [SELECIONA_ECRA], R7
	CALL  apaga_boneco 			; apaga o meteoro
	JMP   reset_alturas 		; gera um novo


; *****************************************************************************
; *                                  ROTINA                                   *
; * 																		  *
; * deteta_colisoes - caso detete uma colisão, escreve o seu tipo em		  *
; * "ha_colisao" (0- não colidiu, 1- colidiu com missil, 2- colidiu com nave) *
; *****************************************************************************

deteta_colisoes:

colisao_asteroide_missil:
	PUSH  R3
	PUSH  R2
	PUSH  R1
	
	ADD	  R1, 1			    			; para desenhar objeto na linha seguinte (abaixo)
	MOV   R3, [pos_missil_linhas]
	SUB	  R1, R3						; posição asteroide menos posição missil     
	ADD   R1, 5							; se após adicionar 5 for positivo, o míssil está na mesma linha do meteoro
	JLE   colisao_asteroide_nave		; se não estiver, vê se vai colidir com a nave

	MOV   R3, [pos_missil_colunas]
	SUB   R2, R3						; se for positivo o míssil está à esquerda do asteroide ou seja, não colidem
	JGT   colisao_asteroide_nave		; logo, sai
	ADD   R2, 5							; se após adicionar 5 for positivo, míssil está na mesma coluna e linha do meteoro
	JLE   colisao_asteroide_nave		; se não estiver, vê se vai colidir com a nave
	MOV   R2, COLIDIU_MISSIL			
	MOV   [ha_colisao], R2				; colidiu com o míssil
	JMP   end_colisoes

colisao_asteroide_nave:
	POP   R1
	POP   R2 							; restaurar o valor das posições
	PUSH  R2
	PUSH  R1

	ADD	  R1, 1							; para desenhar objeto na linha seguinte (abaixo)
	MOV   R3, 24
	SUB	  R1, R3						; 24 é posição mínima do asteróide para colidir com a nave     
	JLT   end_colisoes					; logo, se estiver acima sai

	MOV   R3, [pos_nave_colunas]
	SUB   R2, R3						; se for positivo a nave está à esquerda do asteroide
	JGT   nave_esquerda  				; logo, vai para a label correspondente

nave_direita:							; vê se colidiu com a nave à direita
	ADD   R2, 5							
	JLE	  end_colisoes					; se for negativo, não colidiu
	MOV   R2, COLIDIU_NAVE				
	MOV   [ha_colisao], R2				; colidiu com a nave	
	JMP   end_colisoes					

nave_esquerda:							; vê se colidiu com a nave à esquerda		
	SUB   R2, 5							
	JGE   end_colisoes					; se for positivo, não colidiu
	MOV   R2, COLIDIU_NAVE				
	MOV   [ha_colisao], R2				; colidiu com a nave

end_colisoes:
	POP R1
	POP R2
	POP R3
	RET


; *****************************************************************************
; *                                  ROTINA                                   *
; * muda_animacao - atualiza o desenho do meteoro consoante o número de       *
; * movimentos (R8)                                                           *
; *****************************************************************************
muda_animacao:
	CMP  R9, ASTEROIDE     			; ver se é um asteróide
	JZ   muda_animacao_asteroide
	JMP  muda_animacao_nave 		; então é uma nave inimiga

muda_animacao_asteroide:
	PUSH R8							; preserva-se o valor do contador
	; Vai sempre subtraíndo 3, o número de movimentos necessário para mudar de fase; 
	; quando estiver menor ou igual a zero, pára, ficando na definição correspondente
    MOV  R3, DEF_ASTEROIDE_1		; 1x1
    SUB  R8,3						
    JLE  pop_animacao_asteroide
    MOV  R3, DEF_ASTEROIDE_2		; 2x2
    SUB  R8, 3
    JLE  pop_animacao_asteroide
    MOV  R3, DEF_ASTEROIDE_3		; 3x3
    SUB  R8, 3
    JLE  pop_animacao_asteroide
    MOV  R3, DEF_ASTEROIDE_4		; 4x4
    SUB  R8, 3
    JLE  pop_animacao_asteroide
    MOV  R3, DEF_ASTEROIDE_5		; 5x5
pop_animacao_asteroide:
	POP  R8
	RET

muda_animacao_nave:
	PUSH R8							; preserva-se o valor do contador
	; Vai sempre subtraíndo 3, o número de movimentos necessário para mudar de fase; 
	; quando estiver menor ou igual a zero, pára, ficando na definição correspondente
    MOV  R3, DEF_NAVE_INIMIGA_1		; 1x1
    SUB  R8,3
    JLE  pop_animacao_nave
    MOV  R3, DEF_NAVE_INIMIGA_2		; 2x2
    SUB  R8, 3
    JLE  pop_animacao_nave
    MOV  R3, DEF_NAVE_INIMIGA_3		; 3x3
    SUB  R8, 3
    JLE  pop_animacao_nave
    MOV  R3, DEF_NAVE_INIMIGA_4		; 4x4
    SUB  R8, 3
    JLE  pop_animacao_nave
    MOV  R3, DEF_NAVE_INIMIGA_5		; 5x5
pop_animacao_nave:
	POP  R8
	RET

; *****************************************************************************
; *                                  ROTINA                                   *
; * coluna_aleatoria - Gera uma coluna aleatória dentro dos seguintes         *
; *                    valores: [1,9,17,25,33,41,49,57]                       *
; *****************************************************************************
coluna_aleatoria:
	PUSH R1
	MOV  R1, TEC_COL    		; endereço das colunas do teclado
	MOV  R4, [R1] 				; ler as colunas
	SHR  R4, 5 					; colocar os bits 5-7 em 0-2
	MOV  R1, MASCARA_3b 		; para isolar os 3 bits de menor peso
	AND  R4, R1
	MOV  R1, 8
	MUL  R4, R1 				; R4 - [0,8,16,24,32,40,48,56]
	ADD  R4, 1 					; transformar R4 num destes valores: [1,9,17,25,33,41,49,57]
	POP  R1
	RET

; *****************************************************************************
; *                                  ROTINA                                   *
; * asteroide_ou_nave - determina se o meteoro vai ser um asteróide ou uma    *
; * nave inimiga, com 25% e 75% de chance respetivamente.                     *
; *                                                                           *
; * Retorna:    R9 - ASTEROIDE ou NAVE                                        * 
; *****************************************************************************

asteroide_ou_nave:
	PUSH R1
	MOV  R1, TEC_COL    		; endereço das colunas do teclado
	MOV  R9, [R1] 				; ler as colunas
	SHR  R9, 5 					; colocar os bits 5-7 em 0-2
	MOV  R1, MASCARA_3b 		; para isolar os 3 bits de menor peso
	AND  R9, R1
	CMP  R9, 1 					; 25% = [0,1]; 75% = [2,7]
	JLE  escolhe_asteroide
	MOV  R9, NAVE    			; será uma nave
	JMP  pop_asteroide_ou_nave
escolhe_asteroide:
	MOV  R9, ASTEROIDE 			; será um asteróide
pop_asteroide_ou_nave:
	POP  R1
	RET


; *****************************************************************************
; *                                  ROTINA                                   *
; * houve_colisao_missil - consoante o choque com o míssil ter sido por       *
; * parte de um asteróide ou de uma nave inimiga, não altera nada ou          *
; * restora 5 de energia.                                                     *
; *****************************************************************************

houve_colisao_missil:
	CMP  R9, ASTEROIDE
	JNZ  aumenta_energia_5 		; caso não seja um asteróide, restora 5 de energia
	RET
aumenta_energia_5:
	PUSH R0 
	MOV  R0, 5					; registo com o valor a adicionar ao display
	CALL altera_valor_display
	POP  R0
	RET	


; *****************************************************************************
; *                                  ROTINA                                   *
; * houve_colisao_nave - consoante o choque com a nave ter sido por           *
; * parte de um asteróide ou de uma nave inimiga, restora 10 de energia       *
; * ou termina o jogo, respetivamente.                                        *
; *                                                                           *
; * Retorna:    R9 - ASTEROIDE ou NAVE                                        * 
; *****************************************************************************

houve_colisao_nave:
	CMP  R9, ASTEROIDE			; ver se foi com um asteróide
	JZ   aumenta_energia_10 	; vai aumentar a energia em 10
	PUSH R0					
	MOV  R0, 1
	MOV  [rover_explodiu], R0	; altera a variável para comunicar que o rover explodiu
	POP  R0
	CALL terminar_jogo 			; caso tenha sido com nave, o jogo termina
	RET
aumenta_energia_10:
	PUSH R0 
	MOV  R0, 10					; registo com o valor a adicionar ao display
	CALL altera_valor_display
	POP  R0
	RET


; *****************************************************************************
; *                            PROCESSO - TECLADO                             *
; *                                                                           *          																  
; *  Descrição - Ciclo que varre continuamente todas as linhas do teclado e,  *
; *  ao detectar um clique, alerta os processos que estiverem à espera do     *
; *  mesmo, retornando o valor da tecla lida (0-F).                           *
; *  R2 - endereço do periférico das linhas                                   *
; *  R3 - endereço do periférico das colunas                                  *
; *  R5 - máscara para isolar os 4 bits de menor peso						  * 
; *  R6 - linha a ser testada                                                 *
; *****************************************************************************

PROCESS SP_TECLADO

teclado:
	MOV  SP, SP_TECLADO			; inicializa o stack pointer do processo do teclado
	EI 							; porque tem que se ativar aqui também?
	MOV   R2, TEC_LIN   		; endereço do periférico das linhas
	MOV   R3, TEC_COL   		; endereço do periférico das colunas
	MOV   R5, MASCARA   		; para isolar os 4 bits de menor peso, ao ler as colunas do teclado
ciclo_teclado:
	MOV   R6, LINHA_TECLADO
testa_linha:
	WAIT                       ; espera que alguma tecla seja premida (ou ocorra uma interrupção)

	MOVB  [R2], R6      		; escrever no periférico de saída (linhas)
	MOVB  R0, [R3]      		; ler do periférico de entrada (colunas)
	AND   R0, R5        		; elimina bits para além dos bits 0-3
	CMP   R0, 0					; há tecla premida?
	JZ    troca_linha_teclado   ; testa com nova linha

	CALL  calcula_tecla
	MOV   [tecla_carregada], R7 ; alerta os processos que uma tecla foi pressionada
								; (o valor escrito é o número da coluna da tecla no teclado)

ha_tecla:					; neste ciclo espera-se até NENHUMA tecla estar premida
	YIELD					; este ciclo é potencialmente bloqueante
	
	CALL  calcula_tecla
	MOV	  [tecla_continua], R7 ; informa quem estiver bloqueado neste LOCK que uma tecla está a ser carregada
		 					; (o valor escrito é o número da coluna da tecla no teclado)
    MOVB  R0, [R3]			; ler do periférico de entrada (colunas)
	AND   R0, R5			; elimina bits para além dos bits 0-3
    CMP   R0, 0				; há tecla premida?
    JNZ   ha_tecla			; se ainda houver uma tecla premida, espera até não haver
							
troca_linha_teclado:
    SHR   R6, 1          ; trocar para a próxima linha
    CMP   R6, 0          ; linha == 0000?
    JZ    ciclo_teclado  ; volta a 1000
    JMP   testa_linha	


; *****************************************************************************
; *                                  ROTINA                                   *
; * calcula_tecla - Dado a linha e a coluna do teclado, calcula e retorna     *
; * o valor da tecla pressionada.                                             *
; *                                                                           *
; * Argumentos: R0 - coluna                                                   *
; * 			R6 - linha                                                    *
; * Retorna:    R7 - valor da tecla (0-F)                                     * 
; *****************************************************************************

calcula_tecla:
	PUSH R6
	PUSH R1
	PUSH R0
	MOV  R1, 0
converte_linha:
    SHR  R6, 1
    JZ   multiplica_4
    ADD  R1, 1        		 ; incrementar o contador da linha
    JMP  converte_linha

multiplica_4:
	SHL  R1, 2				 ; multiplica o contador da linha por 4

converte_col:
    SHR  R0, 1
    JZ   exit_calcula_tecla
    ADD  R1, 1        		 ; incrementar o contador da coluna
    JMP  converte_col	

exit_calcula_tecla:
	MOV  R7, R1				 ; valor da tecla final
	POP  R0
	POP  R1
	POP  R6
	RET



; ****************************************************************************
; *                            Rotinas auxiliares                            * 
; ****************************************************************************

; *****************************************************************************
; * DESENHA_BONECO - Desenha um boneco na linha e coluna indicadas            *
; *			    com a forma e cor definidas na tabela indicada.               *
; * Argumentos:  R1 - linha                                                   *
; *              R2 - coluna                                                  *
; *              R3 - tabela que define o boneco                              *
; *****************************************************************************

desenha_boneco:               ; desenha o boneco a partir da tabela 				  
	PUSH  R1
	PUSH  R2       
	PUSH  R3 
	PUSH  R4        
	PUSH  R5             
	PUSH  R6
	PUSH  R9
	PUSH  R10

	MOV	R6, R2			      ; cópia da coluna do boneco
	MOV	R9, [R3]		      ; cópia da largura do boneco
	MOV R5, R9                ; guarda a largura do boneco
	ADD	R3, 2			      ; avança para o endereço da altura
	MOV R10, [R3]			  ; cópia da altura do boneco         
	ADD R3, 2                 ; endereço para a cor do primeiro píxel (2 porque cada cor de pixel é uma word)
	CMP R10, 0 				  ; caso não tenha altura, não há nada a desenhar
	JZ  pop_desenha_boneco

desenha_pixels:       		  ; desenha os pixels do boneco a partir da tabela
	MOV	 R4, [R3]			  ; obtém a cor do próximo pixel do boneco
	CALL escreve_pixel	      ; escreve cada pixel do boneco
	ADD	 R3, 2			      ; avança para o endereço da cor do próximo pixel 
    ADD  R2, 1                ; avança para a próxima coluna
    SUB  R5, 1			      ; menos uma coluna para tratar
    JNZ  desenha_pixels       ; continua até percorrer toda a largura do objeto

desenha_coluna:
	MOV	 R2, R6               ; a coluna volta para o início
	MOV	 R5, R9           	  ; a largura volta ao valor inicial
	ADD  R1, 1            	  ; avança para a próxima linha
	SUB  R10,1             	  ; menos uma linha para tratar
	JGT	 desenha_pixels
	

pop_desenha_boneco:
	POP  R10
	POP	 R9
	POP  R6
	POP  R5
	POP  R4
	POP	 R3
	POP  R2
	POP  R1     
	RET           

; *****************************************************************************
; APAGA_BONECO - Apaga um boneco na linha e coluna indicadas                  *
;			  com a forma definida na tabela indicada.                        *
; Argumentos:   R1 - linha                                                    *
;               R2 - coluna													  *
;               R3 - tabela que define o boneco  							  *
;																			  *
; *****************************************************************************

apaga_boneco:
    PUSH  R1
    PUSH  R2       
    PUSH  R3 
    PUSH  R4        
    PUSH  R5             
    PUSH  R6
    PUSH  R9
    PUSH  R10

    MOV  R6, R2                 ; cópia da coluna do boneco
    MOV  R9, [R3]               ; cópia da largura do boneco
    MOV  R5, R9                 ; guarda a largura do boneco
    ADD  R3, 2                  ; avança para o endereço da altura
    MOV  R10, [R3]              ; cópia da altura do boneco         
    ADD  R3, 2                  ; endereço para a cor do primeiro píxel (2 porque cada cor de pixel é uma word)

apaga_pixels:                 	; desenha os pixels do boneco a partir da tabela
    MOV  R4, 0                  ; cor para apagar o próximo pixel do boneco
    CALL escreve_pixel          ; apaga cada pixel do boneco
    ADD  R3, 2                  ; avança para o endereço da cor do próximo pixel 
    ADD  R2, 1                  ; avança para a próxima coluna
    SUB  R5, 1                  ; menos uma coluna para tratar
    JNZ  apaga_pixels           ; continua até percorrer toda a largura do objeto

apaga_coluna:
    MOV  R2, R6                 ; a coluna volta para o início
    MOV  R5, R9                 ; a largura volta ao valor inicial
    ADD  R1, 1                  ; avança para a próxima linha
    SUB  R10,1                  ; diminui a altura
    JGT  apaga_pixels
    
pop_apaga_boneco:
    POP  R10
    POP  R9
    POP  R6
    POP  R5
    POP  R4
    POP  R3
    POP  R2
    POP  R1     
    RET  


; *****************************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.               *
; Argumentos:   R1 - linha 													  *
;               R2 - coluna													  *
;               R4 - cor do pixel (em formato ARGB de 16 bits) 				  *
;																			  *	
; *****************************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R4		; altera a cor do pixel na linha e coluna já selecionadas
	RET

; ****************************************************************************
; * ATRASO - Faz "ATRASO" iterações, para implementar um atraso no tempo,    *
; *		 de forma não bloqueante.                                            *
; *                                                                          *
; * Argumento: R11 - valor do atraso atual                                   *
; * Retorna:   R11 - Se 0, o atraso chegou ao fim                            *
; ****************************************************************************
atraso:					
	CMP R11, 0			; é zero?
	JZ  reset_atraso	
	SUB	R11, 1			; vai diminuíndo o atraso
	JMP	exit_atraso
reset_atraso:
	MOV R11, ATRASO		; reseta o atraso
exit_atraso:
	RET

; ****************************************************************************
; *                          Rotinas de interrupção                          * 
; ****************************************************************************

rot_int_displays:				; assinala que a interrupção ocorreu
	MOV [int_displays], R0		; o valor de R0 é irrelevante
	RFE	

rot_int_meteoros:				; assinala que a interrupção ocorreu
	MOV [int_meteoros], R7	    ; o valor de R7 é irrelevante
	RFE
	
rot_int_missil:					; assinala que a interrupção ocorreu
	MOV [int_missil], R8 		; valor de R8 é irrelevante
	RFE