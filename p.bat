@echo off
if [%1] == [] goto SYNTAXE

git add .
git commit -m "%1"
git push


goto FIN

:SYNTAXE
echo "_________________________________"
echo "*** ERREUR DE SYNTAXE ***"
echo "Le texte du commit -m est absent"
echo "exemple :"
echo "p texte du commit"
echo "_________________________________"

:FIN