#!/bin/bash

#Клиент: https://github.com/httpie/cli

#. .config
. categories.sh

jsons=($(find -wholename './new_actives/*.json'))
for i in ${jsons[@]};do 
	cat_id=`echo "$i" | sed 's/[^0-9]//g'`
	https -A bearer -a $token GET ${base}'actives_category/'${cat_id} > temp 
	echo 'Создание тестового актива в категории: ' $(jq '."hydra:member"[0][0].name' temp)
	
	
done


echo 'Создание, изменение и удаление нового актива:'

#https -A bearer -a $token POST ${base}'create_active' < new_active.json

