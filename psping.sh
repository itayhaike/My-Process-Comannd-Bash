#!/bin/bash
#Psping
#Itay Haike
counter=0

function check() {
	if [ $# -eq 1 ]; then
		while true; do
			echo "$(pgrep -l $1): $(pgrep -c $1) instance(S)..."
		done
	else
		while getopts "c:l:t:u:" opt; do
			case $opt in
				c)  c_func  ${OPTARG}  ${@: -1} ;;
				t) t_func ${OPTARG} ${@: -1} ;;
				u) u_func ${OPTARG} ${@: -1};;
				\?) help ; exit 1 ;;
			esac
		done
    fi
}

function help(){
    echo ''' 
    -c - limit amount of pings, e.g. -c 3. Default is infinite
    -t - define alternative timeout in seconds, e.g. -t 5. Default is 1 sec
    -u - define user to check process for. Default is ANY user.
    '''
}

function c_func() {
    while [ $counter -lt $1 ]; do
    	echo "$(pgrep -l $2): $(pgrep -c $2) instance(S)..."
    	(( counter++ ))
    	echo " RUN $counter Times.."
    done
}

function t_func(){
    while true; do
    	echo "$(pgrep -l $2): $(pgrep -c $2) instance(S)..."
    	(( counter++ ))
    	echo " RUN $counter Times.."
    	sleep $1
    	break
    done
}

function u_func(){
    echo "$(pgrep -lu $1 $2): $(pgrep -c $2) instance(S)..."
    (( counter++ ))
    echo " RUN $counter Times.."
}

check $@
