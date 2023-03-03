#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
##
## Aluno: Nº: 99196       Nome: Diogo Paciência 
## Nome do Módulo: agendamento.sh
## Descrição/Explicação do Módulo: Este módulo pega nos médicos marcados como disponíveis, e agenda as vacinações de todos os cidadãos da sua localidade, estas sendo efetuadas pelo médico. Estes agendamentos são guardados no ficheiro
## "agenda.txt", e contêm as seguinte informações: nome do enfermeiro, número da cédula pessoal do enfermeiro, nome do cidadão, número de utente do cidadão, centro de saúde e a data de vacinação (que corresponde à data atual).
##
###############################################################################

if [ -f "agenda.txt" ]; then	# verifica se o ficheiro "agenda.txt" já existe.
    rm "agenda.txt"								    # elimina o ficheiro "agenda.txt", se este já existir.
fi

while read line; do				# lê o ficheiro "enfermeiros.txt" e inicializa o ciclo while que irá percorrer este ficheiro linha-a-linha.

    estado=$(echo "$line" | cut -d":" -f5)			# mostra a linha, e corta todos os ":", isolando o quinto argumento após este corte (a disponibilidade do enfermeiro), acabamos assim com a disponibilidade do enfermeiro na variável														   "estado".

    if [[ $estado -eq 1 ]]; then					# verifica se a disponibilidade do enfermeiro (guardada na variável "estado") é igual a 1.
													# se a disponibilidade do enfermeiro for igual a 1, acontece o seguinte:
       
	    nome=$(echo "$line" | cut -d":" -f2)					# mostra a linha, e corta todos os ":", isolando o segundo argumento após este corte (o nome do enfermeiro), acabamos assim com o nome do enfermeiro na variável "nome".
       
	    cedula=$(echo "$line" | cut -d":" -f1)					# mostra a linha, e corta todos os ":", isolando o primeiro argumento após este corte (o número de cédula profissional do enfermeiro), acabamos assim com o número de cédula																   profissional do enfermeiro na variável "cedula".
        
		centrosaude=$(echo "$line" | cut -d":" -f3)				# mostra a linha, e corta todos os ":", isolando o terceiro argumento após este corte (o centro de saúde do enfermeiro), acabamos assim com o centro de saúde do enfermeiro																	   na variável "centrosaude".

	    local=$(echo "$centrosaude" | sed "s/CS//")				# cria a variável "local", que mostra o conteúdo da variável "centrosaude" (o centro de saúde do enfermeiro), mas corta as primeiras letras "CS", de forma a guardar a																		   localidade do centro de saúde na variável "local". 
	
		while read line; do										# lê o ficheiro "cidadaos.txt" e inicializa o ciclo while que irá percorrer este ficheiro linha-a-linha.

			cidlocal=$(echo "$line" | cut -d":" -f4)						# mostra a linha, e corta todos os ":", isolando o quarto argumento após este corte (a localidade do cidadão), acabamos assim com a localidade do cidadão na																				   variável "cidlocal".
		
			if [[ $local == $cidlocal ]]; then								# verifica se a localidade do centro de saúde do enfermeiro (guardada na variável "local" é a mesma localidade do cidadão (guardada na variável "cidlocal").
																			# se a localidade do centro de saúde do enfermeiro e a localidade do cidadão forem as mesmas, acontece o seguinte:
			
				cidnome=$(echo "$line" | cut -d":" -f2)									# mostra a linha, e corta todos os ":", isolando o segundo argumento após este corte (o nome do cidadão), acabamos assim com o nome do cidadão na																							   variável "cidnome".
				
				cidnr=$(echo "$line" | cut -d":" -f1)									# mostra a linha, e corta todos os ":", isolando o primeiro argumento após este corte (o número de utente do cidadão), acabamos assim com o número de																						   utente do cidadão na variável "cidnr".
				
				data=$(date +%F)														# guarda a data atual, no formato <ano>-<mês>-<dia>, na variável "data".
			
				echo "$nome:$cedula:$cidnome:$cidnr:$centrosaude:$data" >> agenda.txt	# guarda a informação do agendamento, no formato <nome do enfermeiro>:<número da cédula pessoal do enfermeiro>:<nome do cidadão>:																											   <número de utente do cidadão>:<centro de saúde>:<data de vacinação>, no ficheiro "agenda.txt".
		
			fi
		done < cidadaos.txt										# fecha o segundo ciclo while.
    fi
done < enfermeiros.txt			# fecha o primeiro ciclo while.
