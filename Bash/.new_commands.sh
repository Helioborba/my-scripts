#!/bin/bash

###### PYTHON #######
## Iniciar Venv
function checar() { #Checa se o venv esta ativo (no caso, o venv TEM de se chamar venv (ou se quiser mudar o nome no script em si) para funcionar)
	if [[ "$VIRTUAL_ENV" != "" ]];
	then
		echo "'ERROR' : O venv já está ativado!"
	else
		echo "O venv está sendo ativado..."
		source venv/Scripts/activate
	fi		
}

## Iniciar Flask
function enflask() { #Script principal, vai rodar o flask em modo de desenvolvimento, necessita do parametro start
	checar # execultar a validação do VENV (Caso não use o VENV, retirar esta linha!)
	if [ "$1" = 'start' ];
	then
		echo "Iniciando o flask... apenas um segundo!"
		export FLASK_APP=app
		export FLASK_ENV=development
		flask run
		echo 'flask fechado.'
	else
		echo "Opção de inicialização não encontrado! tente a opção 'start'!"
	fi
}

## Flask migrate/update
function enmigrate() { #Rapido upgrade (commit) da DB, necessita do parametro da mensagem para ser o commit
	if [ "$1" = '' ]; # Bloquear caso a pessoa não coloque a mensagem
	then
		echo "Não foi digitado mensagem!" 
	else
		if [ -d "./migrations" ]; # Checar se já foi criado a db
		then
			# Take action if $DIR exists. #
			echo "Migrations já existe, execultando task..."
		else
			echo "Migrations não existe, criando.. "
			flask db init
		fi
		if (( $# > 1 )); # ter certeza que não foi digitado sem aspas a mensagem
		then
			echo "Este commando NÃO aceita parametros extras! utilize 'aspas' para a mensagem!"
		else
			echo "Realizando operações da DB"
			flask db migrate -m "$1"
			flask db upgrade
			echo "task terminado."
		fi
	fi
}

###### GIT #######
## Commit Simplificado
function gitrapido() { #Fazer commit com tudo, só necessita da mensagem
	if [ "$1" = '' ]; # Bloquear caso a pessoa não coloque a mensagem
	then
		echo "Não foi digitado a mensagem de commit!" 
	else
		if (( $# > 1 )); # ter certeza que não foi digitado sem aspas a mensagem
		then
			echo "Este commando NÃO aceita parametros extras! utilize 'aspas' para a mensagem!"
		else
			echo "Execultado o commit"
			git add *
			git commit -m "$1"
			git push
		fi
	fi
}


## Criar repo local/Commit para o remote, é necessario passar o remote como parametro!
function gitcriar() { # fazer o primeiro push utilizando um diretório que já tenha arquivos
	read  -n 1 -p "Por favor, aperte ENTER..." # ter certeza que a pessoa esta lendo o promp
	read  -n 1 -p "A origin é esta? "$1" (s/n)" selecionado
	if [ "${selecionado,}" = "s" ];
	then
		echo "Criando..."
		git init
		git add *
		git commit -m "initial commit" # Não é necessario mudar esta tag
		git branch -M main
		git remote add origin "$1"
		git push -u origin main
		echo "Sucesso! task terminad."
	else
		echo "Cancelado"
	fi	
}

# function teste12() { # Utilizado como template para alguns commandos
	
# }

