#!/bin/bash
#######    PSPING     #########
#######    Itay Haike #########
counter=0

function main(){
    check $@
    while true; do
        echo "$(pgrep -l $1): $(pgrep -c $1) instance(S)..."
        (( counter++ ))
    done
}

function check(){
    
    local OPTIND opt i
    while getopts ":ctu:" opt; do
        case $opt in
            c) c_func ; input_c="$OPTARG" ;;
            t) t_func ; input_t="$OPTARG" ;;
            u) u_func ; input_u="$OPTARG" ;;
            \?) help ; exit 1 ;;
        esac
    done
    shift $((OPTIND -1))

}

function help(){
    echo ''' 
    -c - limit amount of pings, e.g. -c 3. Default is infinite
    -t - define alternative timeout in seconds, e.g. -t 5. Default is 1 sec
    -u - define user to check process for. Default is ANY user.
    '''
}

function c_func(){
    shift
    while [ $counter -le $input_c ]; do
    	echo "$(pgrep -l $1): $(pgrep -c $1) instance(S)..."
    	(( counter++ ))
    	echo " RUN $counter Times.."
    done    	
}
function t_func(){
    while true; do
    	echo "$(pgrep -l $1): $(pgrep -c $1) instance(S)..."
    	(( counter++ ))
    	echo " RUN $counter Times.."
    	sleep $input_t
    	break
    done    	
}

function u_func(){
    echo "$(pgrep -lu $input_u $1): $(pgrep -c $1) instance(S)..."
    (( counter++ ))
    echo " RUN $counter Times.."
    
}

main $@
check $@
