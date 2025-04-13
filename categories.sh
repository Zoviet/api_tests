#!/bin/bash

#Клиент: https://github.com/httpie/cli

. .config

rm -f new_actives/*.json

pages=($(https -A bearer -a $token GET ${base}'actives_categories?page=1' | jq '."hydra:totalItems"'))
echo 'Страниц: '${pages}

for (( i=1; i <= pages; i++ ))
do
	https -A bearer -a $token GET ${base}'actives_categories?page='${i} > temp
	echo 'Паджинация: '${i}
	echo 'Всего категорий: ' $(jq '."hydra:member"[0] | length' temp)
	for id in $(jq -r '."hydra:member"[][].id' temp)
	do	
		https -A bearer -a $token GET ${base}'actives_category/'${id} > temp 
		echo 'Категория: ' $(jq '."hydra:member"[0][0].name' temp)
		parent=($(jq '."hydra:member"[0][0].parent_id' temp))
		https -A bearer -a $token GET ${base}'get_active/0/'${id} > temp
		data=$(jq -r '."hydra:member"[0][0].data' temp )
		jq -r '{name: "Тестовый актив", categoryId: '${id}', data: null, active: true, auto: true}' temp > new_actives/${id}'.json' 
		sed -i "s/null/${data}/g" new_actives/${id}.json
		if [ $(jq '."hydra:member"[0] | length' temp) -eq "0" ]; then
			if [[ "$parent" == null ]]; then
				printf '\033[92mРодительская категория\033[0m\n'
			else
				printf '\033[91mНе найден нулевой актив!\033[0m\n'	
			fi
		fi
	done
done
