#!/usr/bin/sh

check_docker_img=`docker image list | grep get_row | awk '{print($1)}''`

if [[ $check_docker_img ]]
     then
	docker image rm get_row; exit 0
     else
        exit 0
fi
