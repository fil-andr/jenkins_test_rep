#!/bin/bash


check_docker_cont=`docker ps | grep get_row_from_db_get_row_1 |awk '{print($1)}'`

if [[ $check_docker_cont ]]
     then
	docker stop get_row_from_db_get_row_1; exit 0
     else
        exit 0
fi
