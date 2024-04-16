                            .data
vetor:                      .space 100                        # Vetor para armazenar a entrada do usuário
mensagem_Receber_Palavra:   .asciiz "Digite uma palavra: "    # Mensagem para receber a palavra

    .text
    .globl main

main:
                                                              # Imprimir a mensage para o usuário
    li   $v0, 4           		
    la $a0, mensagem_Receber_Palavra    
    syscall

    # Lendo a entrada do usuário
    li $v0, 8           
    la $a0, vetor      
    li $a1, 100         
    syscall

    # Chamando a função string_length
    la $a0, vetor      # Carrega o endereço do buffer contendo a entrada do usuário
    jal string_length
    
    # Imprimindo o resultado
    
Resultado:
    move $a0, $v0       # Carrega o resultado (tamanho da string) em $a0
    li $v0, 1           
    syscall             
    
    # Sair do programa
    li $v0, 10          
    syscall

# Função para calcular o comprimento da string
string_length:
    # Definindo os registradores
    move $t0, $a0       # $t0 = $a0 (Endereço inicial da string)
    move $t1, $zero     # $t1 = 0 (Inicializando o contador de comprimento)

loop:
    lb $t2, 0($t0)      # Carrega o byte apontado por $t0 em $t2
    beqz $t2, end       # Se $t2 == 0, vai para o final da função
    
    addi $t0, $t0, 1    # Avança para o próximo byte da string
    addi $t1, $t1, 1    # Incrementa o contador de comprimento
    j loop              # Loop
    
end:
    sub $v0, $t1, 1     # $v0 = $t1 (tamanho da string) - 1 (descontando o caractere nulo)
    jr $ra              # Retorna
