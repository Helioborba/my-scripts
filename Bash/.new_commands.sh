#!/bin/bash

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
	checar # execultar a validação do VENV
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

## Commit Simplificado
function gitrapido() { #Fazer commit com tudo, só necessita da mensagem
	if (( $# > 1 )); # ter certeza que não foi digitado sem aspas a mensagem
	then
		echo "Este commando NÃO aceita parametros extras! utilize 'aspas' para a mensagem!"
	else
		echo "Execultado o commit"
		git add *
		git commit -m "$1"
		git push
	fi
}

## Criar repo local/Commit para o remote
function gitcriar() { # fazer o primeiro push utilizando um diretório que já tenha arquivos
	read  -n 1 -p "Deseja realmente criar o git neste diretório? (s/n)" selecionado
	if [ "${selecionado,}" = "s" ];
	then
		echo "Criando..."
		git init
		git add *
		git commit -m "initial commit" # Não é necessario mudar esta tag
		git branch -M main
		git remote add origin https://github.com/Helioborba/my-scripts.git
		git push -u origin main
		echo "Sucesso! task terminado"
	else
		echo "Cancelado"
	fi	
}

