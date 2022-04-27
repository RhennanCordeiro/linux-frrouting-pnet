#!/bin/bash
function download(){
curl gdrive.sh | bash -s https://drive.google.com/drive/folders/1IE3jlL6ocPlxHVtkkBauPqsgKm6OFwLd?usp=sharing

}
function instalar(){
cd $(ls -d */)

cp -r $(ls | grep *.yml) /opt/unetlab/html/templates/
cp -r $(ls | grep *.png) /opt/unetlab/html/images/icons/


dir=$(pwd | rev | cut -d / -f 1 | rev)
mkdir -p /opt/unetlab/addons/qemu/$dir
if [ -z $(ls | grep *.qcow2) ]
then
	echo "Arquivo qcow2 ausente"
else
	cp -r $(ls | grep *.qcow2) /opt/unetlab/addons/qemu/$dir
fi
/opt/unetlab/wrappers/unl_wrapper -a fixpermissions

}

if [ ! $(command -v curl & > /dev/null) ]
then
	echo "Você precisa do curl instalado na máquina"
	echo "Dependendo da sua distro, podem ser um esses comandos..."
	echo "sudo yum install curl"
	echo "sudo apt install curl"
	echo "sudo pacman -S curl"
	echo "sudo pkg install curl"
	sleep 2
	exit
fi	

echo "#########################################"
echo "DIGITE O NUMERO DA OPÇÃO DESEJADA"
echo "Essa Máquina é o servidor do PNET ?"
echo "1 - Sim"
echo "2 - Não"
echo "#########################################"
read servidor

if [ $servidor == '1' ]
then
	echo "#########################################"
	echo "BOM, JA QUE ESTAMOS NO SERVIDOR, O QUE VOCE PREFERE ?"
	echo "1 - Apenas fazer o Download"
	echo "2 - Fazer o download e instalar"
	echo "#########################################"
	read opcao

	if [ $opcao == '1' ]
	then
		download

	elif [ $opcao == '2' ]
	then
		download
		instalar	
	else
		echo "Opcao Incorreta"
	fi
	
elif [ $servidor == '2' ]
then
	echo "Tudo bem, apenas o download será feito"
	sleep 3
	download
	
else
	echo "Opcao Incorreta"
fi