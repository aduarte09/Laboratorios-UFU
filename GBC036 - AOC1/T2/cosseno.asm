		.data
x: 		.float 30.0         			# ângulo em graus
pi: 		.float 3.141592
divisor: 	.float 180.0
precisao: 	.float 0.00001
um: 		.float 1.0
result_msg:	.asciiz "O cosseno de x foi calculado e é: "

		.text
main:
        						# conversão de ângulo para radianos
	lwc1 	$f0, x            			# atribui o valor do ângulo em graus
        lwc1	$f1, pi           			# atribui o valor de pi
        lwc1 	$f10, divisor
        mul.s 	$f0, $f0, $f1   			# graus * pi
        div.s 	$f0, $f0, $f10   			# divide o ângulo por 180 graus
        j 	cosex                			# chamada da função cosex

    							# cálculo do cosseno de x
cosex:
        mtc1 	$zero, $f5        			# inicializa $f5 com zero para ser usado posteriormente
        add.s 	$f2, $f0, $f5    			# carrega o resultado com x em $f2
        lwc1 	$f7, precisao     			# carrega o valor de "precisao" em $f7, para posterior comparação
        li 	$t0, 2              			# inicializa o fator de x^2
        lwc1 	$f11, um              			# inicializa o sinal (alternância)

loop:
        mul.s 	$f4, $f0, $f0    			# cálculo x^2
        mtc1 	$t0, $f3          			# carrega o fator de x^2 para um registrador de ponto flutuante
        div.s 	$f4, $f4, $f3    			# divide por (2*k*(2*k-1))
        mul.s 	$f4, $f4, $f2    			# multiplica pelo termo atual
        mul.s 	$f4, $f4, $f1    			# aplica o sinal (pi)
        mul.s 	$f4, $f4, $f11    			# aplica o sinal alternante
        sub.s 	$f2, $f2, $f4
        addi 	$t0, $t0, 2       			# incrementa o fator de x^2
        neg 	$t1, $t1           			# alterna o sinal
        c.lt.s 	$f2, $f7        			# compara o termo atual com a precisão especificada
        bc1t 	end_loop          			# se for menor que a precisão, termina o loop
        j 	loop                 			# volta ao início do loop

end_loop:
        						# impressão do resultado
        li	$v0, 4               			# syscall para imprimir uma string
        la 	$a0, result_msg      			# carrega o endereço da mensagem
        syscall

        li 	$v0, 2               			# syscall para imprimir um float
        mov.s 	$f12, $f0         			# carrega o resultado do cosseno em $f12
        syscall

        						# termina o programa
        li 	$v0, 10              			# código do syscall para sair do programa
        syscall
