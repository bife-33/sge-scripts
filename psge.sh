#!/bin/bash
#source /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
source ~/.bashrc

# Exibição de erros [1 = habilitado | 0 = desabilitado]
OPTERR=0

while getopts c:C: flag
do
    case "${flag}" in
        c) BANCO=${OPTARG};;
        C) DB=${OPTARG};;
        ?) echo " >> Comando [ "$1" ] desconhecido. Execute [ -c instituicao ] para conectar na 5433 ou [ -C nome_completo_da_base ] para conectar na 5432.";exit 1;
    esac
done

# Valores padrões para as variáveis
if [ -z $DB ]
then
 DB='null'
fi
if [ -z $BANCO ]
then
 BANCO='null'
fi

if [ $BANCO != 'null' ]
then
 sudo -i -u postgres psql -p5433 -hdatabase.solis.com.br sagu_${BANCO^^}_diario
exit 0;
fi;

if [ $DB != 'null' ]
then
 sudo -i -u postgres psql -p5432 -hdatabase.solis.com.br ${DB}
exit 0;
fi;
