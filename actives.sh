#!/bin/bash

#Клиент: https://github.com/httpie/cli

. .config

pages=($(https -A bearer -a $token GET ${base}'get_actives?page=1' | jq '."hydra:totalItems"'))
echo 'Страниц: '${pages}

for (( i=1; i <= pages; i++ ))
do
	https -A bearer -a $token GET ${base}'get_actives?page='${i} > temp
	echo 'Паджинация: '${i}
	echo 'Всего активов: ' $(jq '."hydra:member"[0] | length' temp)
	for id in $(jq -r '."hydra:member"[].id' temp)
	do	
		https -A bearer -a $token GET ${base}'get_active/'${id} > temp	
		echo 'Актив: ' $(jq '."hydra:member"[0][0].name' temp)
	done
done



