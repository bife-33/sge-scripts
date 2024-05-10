# SolisGE Scripts

Scripts úteis para facilitar uso do SolisGE dentro e fora do docker.

## Instalação

**Obs:** Executar comandos com o usuário _root_

1. Definir nome dos seus diretórios do SolisGE e da pasta de Scripts:
```bash
export TRUNK=solisge_trunk
export BETA=solisge_beta
export STABLE=solisge_stable
export SCRIPTS=sge-scripts
```
2. Download dos arquivos:
```bash
mkdir /var/docker/$SCRIPTS
git clone https://github.com/bife-33/sge-scripts.git $SCRIPTS
cd /var/docker/$SCRIPTS
```
3. Configuração do arquivo de instalação:
```bash
sed -i "s:STRUNK=.*:STRUNK=${TRUNK}:g" instalar_scripts_sge.sh
sed -i "s:SBETA=.*:SBETA=${BETA}:g" instalar_scripts_sge.sh
sed -i "s:SSTABLE=.*:SSTABLE=${STABLE}:g" instalar_scripts_sge.sh
sed -i "s:SSCRIPTS=.*:SSCRIPTS=${SCRIPTS}:g" instalar_scripts_sge.sh
```
4. Executar arquivo de instalação:
```bash
chmod +x instalar_scripts_sge.sh && ./instalar_scripts_sge.sh
```

5. Executar cat para ver todos os alias registrados:
```bash
cat ~/.sge_aliases | vim -
```

6. Dentro do docker, executar arquivo de instalação dos alias internos:
```bash
cd /var/www/.scripts && ./instalar_scripts_docker.sh
```
