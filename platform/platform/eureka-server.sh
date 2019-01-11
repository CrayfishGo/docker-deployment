#!/usr/bin/env bash

# 定义颜色
RED='\e[1;31m'
GREEN='\e[1;32m'
NC='\e[0m'

serviceName="eureka-server"
image="evan1120/eureka-server:latest"
network="spring-cloud"
replicas="2"
memory="2g"

if [[ "$1" == "create" ]]
then
    if(docker service ls | grep "$serviceName")
    then
        echo -e "${RED} the service $serviceName has been existed ${NC}"
        exit 0
    else
        docker pull ${image}
        echo -e "${GREEN} creating $serviceName ... ${NC}"
        docker service create \
            --hostname ${serviceName} \
            --with-registry-auth \
            --env-file ./platform.env \
            --network ${network} \
            --limit-memory ${memory} \
            --replicas ${replicas} \
            --name ${serviceName} \
            --publish 8877:8877 \
            ${image}
        echo -e "${GREEN} create $serviceName success ${NC}"
        exit 0
    fi
elif [[ "$1" == "update" ]]
then
    if(docker service ls | grep "$serviceName")
    then
        docker pull ${image}
        echo -e "${GREEN} updating $serviceName ... ${NC}"
        docker service update \
                --hostname ${serviceName} \
                --with-registry-auth \
                --limit-memory ${memory} \
                --replicas ${replicas} \
                --image ${image} \
                ${serviceName}
        echo -e "${GREEN} update $serviceName success ${NC}"
        exit 0
    else
        echo -e "${RED} the service $serviceName not existed ${NC}"
        exit 0
    fi
else
    exit 0
fi