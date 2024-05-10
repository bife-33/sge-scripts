#!/bin/bash

echo ""
echo " >> Iniciando instalação do comando sge e outros atalhos..."
echo ""

# Se arquivo existe dentro de .bashrc, não insere novamente
BASHRC=$(grep -F ". /var/www/.scripts/.sge_docker_aliases" ~/.bashrc)

if [ -z "${BASHRC}" ]; then 
    echo "" >> ~/.bashrc 
    echo ". /var/www/.scripts/.sge_docker_aliases" >> ~/.bashrc
    source ~/.bashrc
fi

echo ""
echo " >> Instalação concluída com sucesso! Execute [ sge -h ] para ver a lista de comandos."
echo ""

