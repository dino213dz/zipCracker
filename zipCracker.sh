#/bin/bash
#
# CHORFA Alla-eddine
# h4ckr213dz@gmail.com
# http://github.com/dino213dz
# Version 0.1 Beta
#
##################################################################"

scripting='\033[0;36m'

#Inti. var. styles
c_erreur='\033[1;31m'
c_exemple='\033[0;31m'
c_titre='\033[1;33m'
c_succes='\033[1;32m'
c_resultat='\033[1;36m'

c_italic='\033[3m'
c_reset='\033[0m'

smiley_smile="\033[1;34m"'ԅ(⊙ᴗ⊙ԅ)'"$reset"
smiley_interrogation="\033[1;34m"'(ಠ_ಠ)'"$reset"
smiley_sad="\033[1;34m"'ಥ_ಥ'"$reset"

#arguments
if [ ${#1} -gt 0 ];then
	fichier_zip=$1	
	if [ ${#2} -gt 0 ];then
		fichier_wordlist=$2
	else
		fichier_wordlist='./zipCrackerWordlist.lst'
	fi
else
	echo -e "$rouge""Il faut préciser un fichier zip à craquer et une wordlist.\n$rouge_fonce$0 ./test_mdp.zip ./zipCrackerWordlist.lst"
	exit -1
fi


#var travail
nb_fichiers_existants=$(ls|wc -l)
nb_mdp=$(cat $fichier_wordlist|wc -l)
no=0

clear
while read pass; do
	no=$(($no+1))
	#clear
	echo -e "$c_titre[$no/$nb_mdp] Test du mot-de-passe: $c_resultat$pass "
	test_unzip=$(unzip -o -P $pass $fichier_zip 2>&1|egrep -vi 'Archive:|testing:|error:|incorrect password|bad CRC')
	if [ ${#test_unzip} -gt 0 ];then
		nb_fichiers_actuel=$(ls|wc -l)
		if  [[ $test_unzip =~ "extracting: " ]];then
			echo -e "$c_titre-------------"$smiley_smile"------------------"
			echo -e "$c_titre#Mot-de-passe trouvé:$c_succes$pass"
			echo -e "$c_titre#Resultat:$c_resultat $test_unzip"
			echo -e "$c_titre#Fichiers:$c_italic $scripting"
			ls -Al
			echo -e "$reset$c_titre-------------------------------------\n"
			break
		fi
		#sleep 3
	fi

done < $fichier_wordlist

echo -e $reset
exit 0
