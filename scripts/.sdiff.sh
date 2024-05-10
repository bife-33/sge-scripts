#!/bin/bash
#source /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#source ~/.bashrc

CAMINHO=$@
CAMINHO_COMPLETO=""

for CAMINHO in "$@"
do

CAMINHO_COMPLETO=${CAMINHO_COMPLETO}" "${CAMINHO}
#echo $CAMINHO_COMPLETO
done

svn diff ${CAMINHO_COMPLETO} | vim -
