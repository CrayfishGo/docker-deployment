#!/bin/bash

echoMenu(){
    echo ""
    echo "Usage: $FILE_NAME OPTION COMMAND"
    echo ""
    echo ""
    echo "Options: "
    echo "  -c          Create a new service"
    echo "  -u          Update an exist service"
    echo ""
    echo "Commands: "
    echo "  config-server              config-server for the configration server"
    echo ""
}

S=$0
FILE_NAME=${S##*/}

while getopts ":c:u:h" arg
do
        case ${arg} in
             c)
                case $OPTARG in
                    config-server)
						platform/eureka-server.sh create
                        exit 0
                        ;;
                    *)
                        echoMenu
                        exit 0
                        ;;
                esac
                ;;
             u)
                 case $OPTARG in
                        config-server)
                            platform/eureka-server.sh update
                            exit 0
                            ;;
                        *)
                            echoMenu
                            exit 0
                            ;;
                 esac
                 ;;
             *)
                echoMenu
                exit 0
                ;;
        esac
done