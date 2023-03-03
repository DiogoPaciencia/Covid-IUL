#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
##
## Aluno: Nº: 99196       Nome: Diogo Paciência 
## Nome do Módulo: adiciona_enfermeiros.sh
## Descrição/Explicação do Módulo: Este módulo serve para adcionar enfermeiros, juntamente com  a sua informação (nome, nº de cédula profissional, centro de saúde associado, e disponibilidade), ao ficheiro "enfermeiros.txt", apresentando
## mensagens de erro caso o centro de saúde associdado já tenha um enfermeiro registado, caso o enfermeiro já esteja inscrito noutro centro de saúde, ou caso não sejam inseridos argumentos suficientes.
##
###############################################################################

if [[ $1 == "" || $2 == "" || $3 == "" || $4 == "" ]]; then										# verifica se os argumentos são strings vazias.
	echo ""
	echo "Erro - Tem de inserir a informação que é pedida"										# se os argumentos forem strings vazias, mostra uma mensagem de erro, que diz que o utilizador não inseriu a informação que é pedida.
else																							# se este não for o caso, então acontece o seguinte:

if [[ -n ${2//[0-9]/} ]]; then																	# verifica se o segundo argumento (número de cédula profissional) contem letras.
	echo ""
    echo "Erro: Número de cédula profissional não pode conter letras."							# se o segundo argumento conter letras, mostra uma mensagem de erro a apontar este erro.
else																							# se este não for o caso, então acontece o seguinte:

if [[ -n ${4//[0-9]/} ]]; then																	# verifica se o quarto argumento (estado de disponibilidade) contem letras.
    echo ""
    echo "Erro: Estado de disponibilidade não pode conter letras."								# se o quarto argumento conter letras, mostra uma mensagem de erro a apontar este erro.
else																							# se este não for o caso, então acontece o seguinte:

if [[ $4 -gt 1 || ${#4} -gt 1 ]] ; then															# verifica se o quarto argumento (estado de disponibilidade) tem mais que um caráter ou se tem um valor maior que 1.
    echo ""
    echo "Erro: Estado de disponibilidade só pode ser 0 (indisponível) ou 1 (disponível)."		# se o quarto argumento tiver mais que um caráter ou um valor maior que 1, mostra uma mensagem de erro a apontar este erro.
else																							# se este não for o caso, então acontece o seguinte:

if [[ $3 != CS* ]]; then																		# verifica se o terceiro argumento (centro de saúde) não começa com as letras CS.
	echo ""
	echo "Erro: Centro de sáude tem de começar com as letras "CS"."								# se o terceiro argumento não começar com as letras CS, mostra uma mensagem de erro a apontar este erro.
else																							# se este não for o caso, então acontece o seguinte:

if [ "$#" -eq 4 ]; then																			# verifica se o número de argumentos inseridos é igual a 4, e se este for o caso, então acontece o seguinte:

	touch enfermeiros.txt																													# cria o ficheiro "enfermeiros.txt".

	nome=$1																																	# guarda o conteúdo do primeiro argumento inserido na variável "nome".

	num_cedula_profissional=$2																												# guarda o conteúdo do segundo argumento inserido na variável "num_cedula_profissional".

	cs=$3																																	# guarda o conteúdo do terceiro argumento inserido na variável "cs".

	disp=$4																																	# guarda o conteúdo do quarto argumento inserido na variável "disp".

	complete="$num_cedula_profissional:$nome:$cs:0:$disp"																					# cria uma variável chamada "complete", que contém a informação das outras variáveis, a qual																																				   pretendemos guardar no ficheiro "enfermeiros.txt".

	if grep "$cs" enfermeiros.txt; then																										# verifica se o centro de saúde introduzido já está associado a outro enfermeiro da lista.

		echo ""
		echo "Erro: O Centro de Saúde introduzido já tem um enfermeiro registado"																	# se já houver outro enfermeiro associado ao centro de saúde introduzido, mostra um erro																																					   a dizer que já existe outro enfermeiro associado a este centro de saúde.

	else																																	# se este não for o caso, então acontece o seguinte:

		 if grep "$num_cedula_profissional" enfermeiros.txt; then																					# verifica o número de cédula profissional do enfermeiro já se encontra associado a outro																																					   centro de saúde.

			echo ""
			echo "Erro: O enfermeiro já está inscrito noutro CS"																							# se o número de cédula profissional do enfermeiro já se encontrar associdado a																																								   outro centro de saúde, mostra um erro a dizer que o enfermeiro já está inscrito																																								noutro centro de saúde.

		else																																		# se este não for o caso, então acontece o seguinte:

			echo "$complete" >> "enfermeiros.txt"																											# guarda o conteúdo da variável "complete" no ficheiro "enfermeiros.txt".

		fi

	fi

	else

		echo "" 
		echo "Erro:Síntaxe:$0<número cédula profissional>:<nome>:<centro saúde associado>:<n° de vacinações efetuadas>:<disponibilidade>"	# se não forem inseridos quatro argumentos, aparece uma mensagem de erro a lembrar o utilizador																																				   da informação necessária para que este script possa correr.

fi

fi

fi

fi

fi

fi

echo ""
echo "A lista de enfermeiros é a seguinte:"
echo ""
cat enfermeiros.txt																				# mostra o ficheiro "enfermeiros.txt".
echo ""
echo "<número cédula profissional>:<nome>:<centro saúde associado>:<nº de vacinações efetuadas>:<disponibilidade (0 – indisponível, 1 – disponível)>"
