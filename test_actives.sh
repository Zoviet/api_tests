#!/bin/bash

#Клиент: https://github.com/httpie/cli

#. categories.sh

jsons=($(find -wholename 'new_actives/*.json'))
for i in ${jsons[@]};do 
echo $i; 
done


echo 'Создание, изменение и удаление нового актива:'

#https -A bearer -a $token POST ${base}'create_active' < new_active.json

