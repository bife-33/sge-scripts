#!/bin/bash

TRUNK=solisge_trunk
BETA=solisge_beta
STABLE=solisge_stable
SOLUCAO=$1;
CAMINHO=$@
COUNT=0;

echo -e "\n\e[1;36m >> Executando meld...\e[00m"

for CAMINHO in "$@"
do

    if [ $COUNT -gt 0 ]
    then

        if [ ${SOLUCAO^^} == '--SGE' ]
        then
            SGET="/var/docker/${TRUNK}/www/solisge/${CAMINHO}"
            SGEB="/var/docker${BETA}/www/solisge/${CAMINHO}"
            SGES="/var/docker/${STABLE}/www/solisge/${CAMINHO}"
            COMANDO="${SGET} ${SGEB} ${SGES}"
        elif [ ${SOLUCAO^^} == '--CORE' ]
        then
            CORET="/var/docker/${TRUNK}/www/portal/${CAMINHO}"
            COREB="/var/docker${BETA}/www/portal/${CAMINHO}"
            COREM="/var/docker/${STABLE}/www/portal/${CAMINHO}"
            COMANDO="${CORET} ${COREB} ${COREM}"
        else
            echo "\n\e[1;36m >> Opção [ ${1} ] desconhecida, utilize [ --sge ] ou [ --core ].\e[00m\n"
            exit 1;
        fi

        #Comando de execução do meld
        sudo meld $COMANDO && wait

    fi

    COUNT=$(expr $COUNT + 1);
done

echo -e "\n\e[1;36m >> Meld finalizado!\e[00m\n"
exit 0;