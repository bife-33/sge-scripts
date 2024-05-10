#!/bin/bash
source ~/.bashrc

# Variáveis das pastas
STRUNK=solisge_trunk
SBETA=solisge_beta
SSTABLE=solisge_stable
SSCRIPTS=sge-scripts

echo ""
echo " >> Iniciando instalação de scripts..."
echo ""

# Configurando arquivo .sge_aliases
echo " >> Configurando arquivo .sge_aliases..."
echo ""

# Se arquivo existe, apaga
if [ -f ~/.sge_aliases ]; then 
    rm -r ~/.sge_aliases
fi

# Cria arquivo de alias e insere
echo "
# Atalhos do SolisGE
alias trunk=\"docker start ${STRUNK} && cd /var/docker/${STRUNK} && ./solisge-docker connect\"
alias beta=\"docker start ${SBETA} && cd /var/docker/${SBETA} && ./solisge-docker connect\"
alias stable=\"docker start ${SSTABLE} && cd /var/docker/${SSTABLE} && ./solisge-docker connect\"
alias update-scripts=\"/var/docker/${SSCRIPTS}/atualizar_scripts_sge.sh\"
alias psge=\"/var/docker/${SSCRIPTS}/psge.sh\"
alias smeld=\"/var/docker/${SSCRIPTS}/smeld3.1.sh\"

# Atalhos para edição de scripts
alias src=\"source ~/.bashrc\"
alias .rc=\"nano ~/.bashrc && src\"
alias .sge=\"nano ~/.sge_aliases && src\"
" >> ~/.sge_aliases

BASHRC=$(grep -F ". ~/.sge_aliases" ~/.bashrc)

if [ -z "${BASHRC}" ]; then 
    echo "" >> ~/.bashrc 
    echo ". ~/.sge_aliases" >> ~/.bashrc
    source ~/.bashrc
fi
# Configurando atualizar_scripts_sge.sh e smeld3.1.sh
echo " >> Configurando atualizar_scripts_sge.sh..."
echo ""

sed -i "s:TRUNK=.*:TRUNK=${STRUNK}:g" /var/docker/${SSCRIPTS}/atualizar_scripts_sge.sh
sed -i "s:BETA=.*:BETA=${SBETA}:g" /var/docker/${SSCRIPTS}/atualizar_scripts_sge.sh
sed -i "s:STABLE=.*:STABLE=${SSTABLE}:g" /var/docker/${SSCRIPTS}/atualizar_scripts_sge.sh
sed -i "s:SCRIPTS=.*:SCRIPTS=${SSCRIPTS}:g" /var/docker/${SSCRIPTS}/atualizar_scripts_sge.sh

sed -i "s:TRUNK=.*:TRUNK=${STRUNK}:g" /var/docker/${SSCRIPTS}/smeld3.1.sh
sed -i "s:BETA=.*:BETA=${SBETA}:g" /var/docker/${SSCRIPTS}/smeld3.1.sh
sed -i "s:STABLE=.*:STABLE=${SSTABLE}:g" /var/docker/${SSCRIPTS}/smeld3.1.sh

# Executando atualizar_scripts_sge.sh
echo " >> Executando atualizar_scripts_sge.sh..."

cd /var/docker/$SSCRIPTS && chmod +x atualizar_scripts_sge.sh && ./atualizar_scripts_sge.sh

echo " >> Instalação concluída com sucesso!"
echo ""
