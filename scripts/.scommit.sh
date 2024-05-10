#!/bin/bash

CHAMADO=$1;
DESCRICAO=$2;
VERSAO=$( echo ${CONTAINERNAME} | cut -d '-' -f 2);

MENSAGEM="Associado com #"${CHAMADO}" ("${VERSAO}"). "${DESCRICAO}

CAMINHO=$@;
CAMINHO_COMPLETO=""

COUNT=0;

for CAMINHO in "$@";
do

 if [ $COUNT -gt 1 ]
 then
  echo $COUNT;
  CAMINHO_COMPLETO=${CAMINHO_COMPLETO}" "${CAMINHO};
 fi

 COUNT=$(expr $COUNT + 1);
done

echo '
svn commit -m "'${MENSAGEM}'"'${CAMINHO_COMPLETO};
