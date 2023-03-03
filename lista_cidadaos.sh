#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
##
## Aluno: Nº: 99196      Nome: Diogo Paciência 
## Nome do Módulo: lista_cidadaos.sh
## Descrição/Explicação do Módulo: Este módulo visa criar uma lista, com o nome "cidadaos.txt", contendo a informação de cada cidadão, retirada do ficheiro "listagem.txt", apresentando a informação da seguinte forma: "<número de utente>:## <nome>:<idade>:<localidade>:<nº telemóvel>:<estado vacinação>".
## No final é apresentado o conteúdo do ficheiro "cidadaos.txt", para podermos observar a informação de cada cidadão neste novo formato, cada linha contendo a informação de um dos cidadãos.
###############################################################################

if [ -f cidadaos.txt ]; then			# verifica se o ficheiro "cidadaos.txt" já existe.
	rm cidadaos.txt						# elimina o ficheiro "cidadaos.txt", se este já existir.  
fi

touch cidadaos.txt						# cria o ficheiro "cidadaos.txt".

nr=10000								# cria a variável "nr", com valor "10000", que será utilizada mais à frente.

cat listagem.txt | while read line; do	# lê o ficheiro "listagem.txt" e inicializa o ciclo while que irá percorrer este ficheiro linha-a-linha.

	utente=$(echo "$line" | grep -n "|" | cut -d":" -f1)					# mostra a linha, indica o número de cada linha, utilizando o grep -n, e após isto, corta todos os ":", isolando o primeiro argumento após este corte (o número                                                                                da linha), acabamos assim com o número da linha na variável "utente". 

	nr=$(($nr+$utente))                                                     # atualiza a variável "nr", adicionando a variável "utente" ao valor "10000", criando assim o número de utente do cidadão).

	nome=$(echo "$line" | cut -d':' -f2 | cut -d'|' -f1)					# mostra a linha, corta todos os ":", isolando o segundo argumento após este corte (o nome do cidadão, seguido pelo separador "|" seguinte, seguido pelas                                                                                      palavras "Data de Nascimento"), após isto, corta todos os "|", isolando o primeiro argumento após este corte (o nome do cidadão), acabamos assim com o nome do                                                                               cidadão na variável "nome".

	nome="${nome::-1}"														# atualiza a variável "nome", apagando o último espaço vazio (que se encontra após o último nome do cidadão).

	idade=$(echo "$line" | cut -d":" -f3 | cut -d"|" -f1 | cut -d"-" -f3)	# mostra a linha, corta todos os ":", isolando o terceiro argumento após este corte (a data de nascimento do cidadão, seguida pelo separador "|" seguinte,                                                                                     seguido pela palavra "Localidade"), corta depois todos os "|", isolando o primeiro argumento após este corte (a data de nascimento do cidadão), após isto,                                                                                   corta todos os "-", isolando o terceiro argumento após este corte (o ano de nascimento do cidadão), acabamos assim com o ano de nascença do cidadão na variável                                                                              "idade".

	idade=$((2021-$idade))													# atualiza a variável "idade", subtraindo o seu valor ao número "2021", obtendo assim a idade do cidadão (ano de nascença do cidadão subtraído a 2021) guardada                                                                                na variável "idade".

	localidade=$(echo "$line" | cut -d"|" -f3 | cut -d":" -f2)				# mostra a linha, corta todos os "|", isolando o terceiro argumento após este corte (a palavra "Localidade", seguida por ":", seguida pela localidade do                                                                                       cidadão), após isto, corta todos os ":", isolando o segundo argumento após este corte (a localidade do cidadão), acabamos assim com a localidade do cidadão na                                                                               variável "localidade".
                                                                              
	localidade="${localidade::-1}"											# atualiza a variável "localidade", apagando o último espaço vazio (que se encontra após a localidade do cidadão).

	telemovel=$(echo "$line" | cut -d"|" -f4 | cut -d":" -f2)				# mostra a linha, corta todos os "|", isolando o quarto argumento após este corte (a palavra "Telemovel", seguida por ":", seguida pelo número de telemóvel do                                                                                 cidadão), após isto, corta todos os ":", isolando o segundo argumento após este corte (o número de telemóvel do cidadão), acabamos assim com o número de                                                                                     telemóvel do cidadão na variável "telemovel".

	final="$nr:$nome:$idade:$localidade:$telemovel:0"						# cria a variável "final", que contem a informação do cidadão de acordo com a sintaxe                                                                                                                                                          <número de utente>:<nome>:<idade>:<localidade>:<nº telemóvel>:<estado vacinação>.

	echo "$final" >> "cidadaos.txt"											# guarda o conteúdo da variável "final" no ficheiro "cidadaos.txt".

done								    # fecha o ciclo while.

echo ""
echo "A lista de cidadãos é a seguinte:"
echo ""
cat cidadaos.txt					    # lê o ficheiro "cidadaos.txt".
echo ""
echo "<número de utente>:<nome>:<idade>:<localidade>:<nº telemóvel>:<estado vacinação>"
