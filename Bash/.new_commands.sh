#!/bin/bash
function checar() { #Checa se o venv esta ativo (no caso, o venv TEM de se chamar venv (ou se quiser mudar o nome no script em si) para funcionar)
	if [[ "$VIRTUAL_ENV" != "" ]];
	then
		echo "'ERROR' : O venv já está ativado!"
	else
		echo "O venv está sendo ativado..."
		source venv/Scripts/activate
	fi
}

function enflask() { #Script principal, vai rodar o flask em modo de desenvolvimento
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


function gitrapido() { #Script principal, vai rodar o flask em modo de desenvolvimento
	if [[ -z "$1" ]];
	then
		echo "Não foi digitado a mensagem para o commit"
	else
		git add *
		git commit -m "$1"
		git push
	fi
}

function gitcriar() {
	
}
