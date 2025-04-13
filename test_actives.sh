#!/bin/bash

#Клиент: https://github.com/httpie/cli

. .config
#. categories.sh

jsons=($(find -wholename './new_actives/*.json'))
for i in ${jsons[@]};do 
	cat_id=`echo "$i" | sed 's/[^0-9]//g'`
	echo 'Создание тестового актива ' $(jq '.name' $i)
	keys=$(jq -r '.data' $i)
	if [[ "$keys" == null ]]; then	
		printf '\033[91mНе найден нулевой актив!\033[0m\n'
	else
		data=''
		for k in $(jq -r '.data | keys | @sh' $i)
		do	
			grep $k defaults.json
		done;
	fi
	#sed -i "s/data:.*$/data:{${data}}/g" $i	
done

#https -A bearer -a $token POST ${base}'create_active' < new_active.json

