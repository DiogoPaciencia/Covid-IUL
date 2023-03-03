#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos
##
## Aluno: Nº: 99196      Nome: Diogo Paciência 
## Nome do Módulo: menu.sh
## Descrição/Explicação do Módulo: Este módulo serve como um menu, de onde o qual se pode acessar todos os scripts anteriormente criados, tendo cinco opções, uma para cada um desses scripts, e a última sendo a opção de sair do menu.
## Após a execução de cada sub-script, o menu volta a ser apresentado e é pedida uma nova opção, isto tudo, tendo em conta as opções e ações anteriores, ou seja, o menu fica em ciclo, e este ciclo permite realizar múltiplas operações
## iterativamente.
###############################################################################

echo ""
echo "COVID-IUL"					# mostra o nome da plataforma COVID-IUL.
echo ""
echo "1. Listar cidadãos"			# mostra a primeira linha do menu, que leva à execução do script "lista_cidadaos.sh".
echo "2. Adicionar enfermeiro"		# mostra a segunda linha do menu, que leva à execução do script "adiciona_enfermeiros.sh".
echo "3. Stats"						# mostra a terceira linha do menu, que leva à execução do script "stats.sh".
echo "4. Agendar vacinação"			# mostra a quarta linha do menu, que leva à execução do script "agendamento.sh".
echo "0. Sair"						# mostra a quinta, e última linha do menu, que permite sair do script "menu.sh".
echo ""
echo "Selecione uma das opções. (0-4)"	# pede ao utilizador para selecionar uma das cinco opcções.
echo ""

read input							# lê o input do utlizador (a opção que o utilizador selecionou).

case $input in						# inicia o case, que irá ler o argumento inserido, vendo se este corresponde às opções "1", "2", "3", "4" ou "0", e agindo de acordo com cada opção.
	
	"1")																# se o argumento inserido for "1".
		
	./lista_cidadaos.sh													# executa o script "lista_cidadaos.sh".

	./menu.sh															# executa o script "menu.sh", depois de executar o script "lista_cidadaos.sh", de forma a voltar ao menu inicial.

	;;																	# termina este caso.

	"2")																# se o argumento inserido for "2".
	echo ""
	echo "Insira o nome"												# pede o nome do enfermeiro.
	echo ""
	read nome															# lê o nome inserido.

	echo ""
	echo "Insira o número de cédula profissional"						# pede o número de cédula profissional do enfermeiro.
	echo ""
	read num															# lê o número de cédula profissional inserido.

	echo ""
	echo "Insira o centro de saúde associado"							# pede o centro de saúde do enfermeiro.
	echo ""
	read cs																# lê o centro de saúde inserido.

	echo ""
	echo "Insira a disponibilidade (0 - indisponível, 1 - disponível)"	# pede a disponibilidade do enfermeiro.
	echo ""
	read disp															# lê a disponibilidade inserida.

	./adiciona_enfermeiros.sh "$nome" "$num" "$cs" "$disp"				# executa o script "adiciona_enfermeiros.sh", com os argumentos inseridos pelo utilizador.

	./menu.sh															# executa o script "menu.sh", depois de executar o script "adiciona_enfermeiros.sh", de forma a voltar ao menu inicial.

	;;																	# termina este caso.

	"3")																# se o argumento inserido for "3".

	echo ""
	echo "Que informações procura?"										# pergunta ao utilizador que tipo de informação procura.
	echo ""

	echo "cidadaos"														# mostra a primeira opção, que leva à execução do script "stats.sh cidadaos".

	echo "registados"													# mostra a segunda opção, que leva à execução do script "stats.sh registados".

	echo "enfermeiros"													# mostra a terceira opção, que leva à execução do script "stats.sh enfermeiros".
	echo ""

	read info															# lê o input do utlizador (a opção que o utilizador selecionou).

	case $info in														# inicia o case, que irá ler o argumento inserido, e irá executar o script correspondente.

		"cidadaos")																	# se o argumento inserido for "cidadaos".

		echo ""
		echo "Insira localidade"													# pede ao utilizador para inserir a localidade do cidadão.
		echo ""
		read localidade																# lê a localidade inserida.

		echo ""
		./stats.sh cidadaos "$localidade"											# executa o script "stats.sh cidadaos", com o argumento inserido pelo utilizador.

		./menu.sh																	# executa o script "menu.sh", depois de executar o script "stats.sh cidadaos", de forma a voltar ao menu inicial.

		;;																			# termina este caso.

		"registados")																# se o argumento inserido for "registados".

		echo ""
		echo "Eis os nomes e números de utente de todos os cidadãos com mais de 60 anos registados na plataforma, ordenados do mais velho para o mais novo:"
		echo ""
		./stats.sh registados														# executa o script "stats.sh registados".

		./menu.sh																	# executa o script "menu.sh", depois de executar o script "stats.sh registados", de forma a voltar ao menu inicial.

		;;																			# termina este caso.

		"enfermeiros")																# se o argumento inserido for "enfermeiros".
	
		echo ""
		echo "Eis todos os enfermeiros assinalados como disponíveis na plataforma: "
		echo ""
		./stats.sh enfermeiros														# executa o script "stats.sh enfermeiros".

		./menu.sh																	# executa o script "menu.sh", depois de executar o script "stats.sh enfermeiros", de forma a voltar ao menu inicial.

		;;																			# termina este caso.

		*)																			# se o argumento inserido for diferente das três possibilidades.
		
		echo ""

		echo "Tem de inserir uma das três opções."									# mostra uma mensagem de erro a dizer para o utilizador inserir uma das três opções.

		./menu.sh																	# executa o script "menu.sh", de forma a voltar ao menu inicial.

		;;																			# termina este caso

	esac																# termina o case.
			
	;;																	# termina este caso.

	"4")																# se o argumento inserido for "4".

	./agendamento.sh													# executa o script "agendamento.sh".
	
	echo ""
	echo "Deseja consultar a agenda?"									# pergunta ao utilizador se deseja consultar o ficheiro "agenda.txt".
	echo ""

	echo "sim"															# mostra a opção "sim", que leva o programa a mostrar o ficheiro "agenda.txt".

	echo "nao"															# mostra a opção "nao", que leva à execução do script "menu.sh", de forma a voltar ao menu inicial.
	echo ""

	read answr															# lê a opção inserida.

	case $answr in														# inicia o case, que irá ler o argumento inserido, e irá escolher a opção de acordo com este.

		"sim")																		# se o argumento inserido for "sim".
		
		echo ""
		echo "Eis a agenda de vacinações:"
		echo ""
		cat agenda.txt																# lê o ficheiro "agenda.txt".
		echo ""
		echo "<nome do enfermeiro>:<número da cédula pessoal do enfermeiro>:<nome do cidadão>:<número de utente do cidadão>:<centro de saúde>:<data de vacinação>"

		./menu.sh																	# executa o script "menu.sh", depois de ler o ficheiro "agenda.txt", de forma a voltar ao menu inicial.

		;;																			# termina este caso.

		"nao")																		# se o argumento inserido for "nao".

		./menu.sh																	# executa o script "menu.sh", de forma a voltar ao menu inicial.

		;;																			# termina este caso.

		*)                                                                          # se o argumento inserido for diferente das duas possibilidades.

        echo ""

        echo "Tem de inserir uma das duas opções."                                  # mostra uma mensagem de erro a dizer para o utilizador inserir uma das duas opções.

        ./menu.sh                                                                   # executa o script "menu.sh", de forma a voltar ao menu inicial.

        ;;                                                                          # termina este caso

	esac																# termina o case.

	;;																	# termina este caso.	

	"0")																# se o argumento inserido for "0".

	echo ""

	echo "Até à próxima!"
	
	echo ""

	exit																# sai do script "menu.sh".

	;;																	# termina este caso.

	*)                                                                  # se o argumento inserido for diferente das cinco possibilidades.

    echo ""

    echo "Tem de inserir uma das cinco opções."                         # mostra uma mensagem de erro a dizer para o utilizador inserir uma das cinco opções.

    ./menu.sh                                                           # executa o script "menu.sh", de forma a voltar ao menu inicial.

    ;;                                                                  # termina este caso

esac								# termina o case.
