#!/bin/bash

#Variáveis das pastas
TRUNK=solisge_trunk
BETA=solisge_beta
STABLE=solisge_stable
SCRIPTS=sge-scripts
NOME_PASTA=".scripts"

if [ -d /var/docker/$TRUNK/www/$NOME_PASTA ]; then
    rm -r /var/docker/$TRUNK/www/$NOME_PASTA
fi
if [ -d /var/docker/$SCRIPTS/$NOME_PASTA ]; then
    cp -r /var/docker/$SCRIPTS/$NOME_PASTA /var/docker/$TRUNK/www/
    chmod -Rf 777 /var/docker/$TRUNK/www/$NOME_PASTA
fi

if [ -d /var/docker/$BETA/www/$NOME_PASTA ]; then
    rm -r /var/docker/$BETA/www/$NOME_PASTA
fi
if [ -d /var/docker/$SCRIPTS/$NOME_PASTA ]; then
    cp -r /var/docker/$SCRIPTS/$NOME_PASTA /var/docker/$BETA/www/
    chmod -Rf 777 /var/docker/$BETA/www/$NOME_PASTA
fi

if [ -d /var/docker/$STABLE/www/$NOME_PASTA ]; then
    rm -r /var/docker/$STABLE/www/$NOME_PASTA
fi
if [ -d /var/docker/$SCRIPTS/$NOME_PASTA ]; then
    cp -r /var/docker/$SCRIPTS/$NOME_PASTA /var/docker/$STABLE/www/
    chmod -Rf 777 /var/docker/$STABLE/www/$NOME_PASTA
fi

echo ""
echo " >> Scripts atualizados com sucesso!"
echo ""