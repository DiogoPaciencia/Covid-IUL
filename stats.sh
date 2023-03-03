#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
##
## Aluno: Nº: 99196       Nome: Diogo Paciência 
## Nome do Módulo: stats.sh
## Descrição/Explicação do Módulo: Este script pode ser utilizado para obter as seguintes informações, dependendo daquilo que o utilizador quer saber: -o nº de cidadãos registados na localidade escolhida.
##																																					   -o Nome e Número de utente dos cidadãos com mais de 60 anos registados na plataforma, 
##																																						ordenados de o mais velho para o mais novo.
##																																					   -o Nome dos enfermeiros assinalados como disponíveis na plataforma. 
###############################################################################

case $1 in	# inicia o case, que irá ler o primeiro argumento inserido, vendo se este corresponde às palavras "cidadaos", "registados" ou "enfermeiros", e agindo de acordo com cada opção.
	
	cidadaos)		# se o primeiro argumento inserido for "cidadaos".

		local=$2																# guarda o segundo argumento inserido (a localidade escolhida) na variável "local".

		num=$(cat cidadaos.txt | grep $local | wc -l)							# lê o ficheiro "cidadaos.txt", mostra todas as linhas deste ficheiro que contenham o conteúdo da variável "local" (a localidade escolhida), e conta o número																				   de linhas que contenham a localidade escolhida, guardando este número na variável "num".
																				  
		echo "O número de cidadaos registados em $local é $num."				# o programa dá como output uma frase que indica o número de cidadãos registados na localidade escolhida pelo utilizador.

	;;				# termina este caso

	registados)		# se o primeiro argumento inserido for "registados".

		cat cidadaos.txt | sort -t":" -k 3 -n -r | uniq | while read line; do	# lê o ficheiro "cidadaos.txt", ordena este ficheiro de acordo com as idades dos cidadãos, indo do mais velho para o mais novo, e inicializa o ciclo                                                                                       while que irá percorrer este ficheiro ordenado linha-a-linha.

			name=$(echo "$line" | cut -d":" -f2)														# mostra a linha, e corta todos os ":", isolando o segundo argumento após este corte (o nome do cidadão), acabamos assim com o nome																											   do cidadão na variável "name".                                                 

			nutente=$(echo "$line" | cut -d":" -f1)														# mostra a linha, e corta todos os ":", isolando o primeiro argumento após este corte (o número de utente do cidadão), acabamos assim                                                                                                          com o número de utente do cidadão na variável "nutente".
		
			age=$(echo "$line" | cut -d":" -f3)															# mostra a linha, e corta todos os ":", isolando o terceiro argumento após este corte (a idade do cidadão), acabamos assim com a																											   idade do cidadão na variável "age".

			if [[ $age -gt 60 ]]; then																	# verifica se a idade do cidadão (guardada na variável "age") é maior que 60.
												
				echo "$name:$nutente"																	# se a idade for maior que 60, o programa dá como output o nome do cidadão seguido pelo seu número de utente, separados por ":".
			fi

		done																	# fecha o ciclo while.

	;;				# termina este caso

	enfermeiros)	# se o primeiro argumento inserido for "enfermeiros".

		cat enfermeiros.txt | while read line; do								# lê o ficheiro "enfermeiros.txt" e inicializa o ciclo while que irá percorrer este ficheiro linha-a-linha.

			docname=$(echo "$line" | cut -d":" -f2)														# mostra a linha, e corta todos os ":", isolando o segundo argumento após este corte (o nome do enfermeiro), acabamos assim com o																											   nome do enfermeiro na variável "docname".
	
			disp=$(echo "$line" | cut -d":" -f5)														# mostra a linha, e corta todos os ":", isolando o quinto argumento após este corte (a disponibilidade do enfermeiro), acabamos assim																										   com a disponibilidade do enfermeiro na variável "disp".

			if [ $disp -eq 1 ]; then																	# verifica se a disponibilidade do enfermeiro (guardada na variável "disp") é igual a 1.
				echo "$docname"																			# se a disponibilidade do enfermeiro for igual a 1, o programa dá como output o nome do enfermeiro.
			fi

		done																	# fecha o ciclo while.

	;;				# termina este caso.

esac        # termina o case.
