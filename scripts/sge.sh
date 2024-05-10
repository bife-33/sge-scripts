#!/bin/bash

# Exibição de erros [1 = habilitado | 0 = desabilitado]
OPTERR=0

# Valores padrões para as variáveis

ATUALIZAR=0; #a
BANCO=0;	 #b
DEPLOY=0;    #d
HELP=0;		 #h
DB='null';   #B
EDIT='null'; #E
SYNC='null'; #S

while getopts abdhB:E:S: flag
do
    case $flag in
	a) ATUALIZAR=1;;
	b) BANCO=1;;
    d) DEPLOY=1;;
	h) HELP=1;;
	B) DB=${OPTARG};;
	E) EDIT=${OPTARG};;
	S) SYNC=${OPTARG};;
	?) echo "Comando [ "$1" ] desconhecido. Execute [ sge -h ] para ver a lista de comandos.";exit 1;
    esac
done
source ~/.bashrc

# Seção [ -h ]
if [ $HELP -eq 1 ]
then
 echo "
   --- Lista de comandos --

   [ -a ] | Atualiza pastas para que não haja erros no deploy.

   [ -b ] | Exibe a base definida no arquivo deploy.conf.

   [ -d ] | Executa o deploy do SolisGE.

   [ -h ] | Exibe a lista de comandos.

   [ -B ('instituição') ] | Executa o deploy e altera para a base a partir do nome da instituição. Ex: [ sge -D uergs ]

   [ -E (conf|update)   ] | Abre os arquivos do instalador do SolisGE (deploy.conf|update.sh) para a edição.

   [ -S (exec|t|f)      ] | Executa sync(exec) ou habilita(t) e desabilita(f) sync no deploy.conf.
 ";
 exit 0;
fi


# Seção [ -b ]
if [ $BANCO -eq 1 ]
then
 echo " "
 echo " > Banco conectado: "$(sed -n 's/.*DB_NAME=\(.*\)/\1/p' /var/www/instalador/deploy.conf)
 echo " "
fi

# Seção [ -a ]
if [ $ATUALIZAR -eq 1 ]
then
	echo " "
	echo " > Atualizando pastas do competo"
	echo " "

	cd /var/www/solisge/competo;
	rm -r * ;
	git pull;
	chmod 777 -Rf /var/www/solisge/competo;

	if [ -e /var/www/solisge/competo/database/migrations/2023_10_10_092617_create_database_audit.php ]
	then
		rm -r /var/www/solisge/competo/database/migrations/2023_10_10_092617_create_database_audit.php;

		echo " "
		echo " > Migration create_database_audit removida"
		echo " "
	fi

	if [ -e /var/www/solisge/competo/database/migrations/2023_10_10_092759_create_audits_table.php  ]
	then
		rm -r /var/www/solisge/competo/database/migrations/2023_10_10_092759_create_audits_table.php;

		echo " "
		echo " > Migration create_audits_table removida"
		echo " "
	fi

#	echo " "
#	echo " > Atualizando pastas do core"
#	echo " "
#
#	cd /var/www/portal && git checkout . && git pull;
#
#	while [ $? -eq 1 ]
#	do
#		echo ""
#		echo " > Credenciais erradas, tente novamente:"
#		echo ""
#		git pull;
#	done

	echo " "
	echo " > Pasta do competo atualizada com sucesso" #e do core atualizadas com sucesso"
	echo " "
fi

# Seção [ -E ]
if [ $EDIT == 'conf' ]
then
 nano /var/www/instalador/deploy.conf
fi

if [ $EDIT == 'update' ]
then
 nano /var/www/instalador/update.sh
fi

# Seção [ -s ]
if [ $SYNC == "f" ]
then
 sed -i "s:DB_SYNC=.*:DB_SYNC=false:g" /var/www/instalador/deploy.conf
fi

if [ $SYNC == "t" ]
then
 sed -i "s:DB_SYNC=.*:DB_SYNC=true:g" /var/www/instalador/deploy.conf
fi

if [ $SYNC == 'exec' ]
then
 php /var/www/solisge/miolo20/modules/basic/classes/sconsolesyncdb.php -mfalse
fi

# Seção [ -d ]
if [ $DEPLOY -eq 1 ]
then
  cd /var/www/instalador/ && ./deploy.sh && cd /var/www/solisge;
fi

# Seção [ -B ]
if [ $DB != 'null' ]
then
  sed -i "s:DB_NAME=.*:DB_NAME=sagu_${DB^^}_diario:g" /var/www/instalador/deploy.conf

  cd /var/www/instalador/ && ./deploy.sh && cd /var/www/solisge;
fi

exit 0;
