#!/bin/bash

BOARD=(1 2 3 4 5 6 7 8 9)
USER=X
SECOND_USER=O
WIN=0
COUNT=0

function display_board {
    echo "   |   |   "
    echo " ${BOARD[0]} | ${BOARD[1]} | ${BOARD[2]} "
    echo "___|___|___"
    echo "   |   |   "
    echo " ${BOARD[3]} | ${BOARD[4]} | ${BOARD[5]} "
    echo "___|___|___"
    echo "   |   |   "
    echo " ${BOARD[6]} | ${BOARD[7]} | ${BOARD[8]} "
    echo "   |   |   "
}

function check_win {
    for field in 0 3 6
    do
        if [ "${BOARD[${field}]}" != " " ] && [ "${BOARD[${field}]}" == "${BOARD[${field}+1]}" ] && [ "${BOARD[${field}]}" == "${BOARD[${field}+2]}" ] ; then
            WIN=1
            return 1
        fi
    done
    
    for field in $(seq 0 2)
    do
        if [ "${BOARD[${field}]}" != " " ] && [ "${BOARD[${field}]}" == "${BOARD[${field}+3]}" ] && [ "${BOARD[${field}]}" == "${BOARD[${field}+6]}" ] ; then
            WIN=1
            return 1
        fi
    done
    
    if [ "${BOARD[0]}" != " " ] && [ "${BOARD[0]}" == "${BOARD[4]}" ] && [ "${BOARD[0]}" == "${BOARD[8]}" ] ; then
        WIN=1
        return 1
    elif [ "${BOARD[2]}" != " " ] && [ "${BOARD[2]}" == "${BOARD[4]}" ] && [ "${BOARD[2]}" == "${BOARD[6]}" ] ; then
        WIN=1
        return 1
    else
        return 0
    fi
}

display_board

for field in $(seq 0 8)
do
    BOARD[$field]=" "
done

while [ "$WIN" == "0" ] && [ $COUNT -lt 9 ]
do
    echo "$USER turn:"
    read choice
    
    until [ $choice -ge 1 ] && [ $choice -le 9 ]
    do 
        echo "Wrong input. Try again."
        read choice
    done
    
    if [ "${BOARD[${choice}-1]}" == " " ] ; then
        BOARD[$choice-1]=$USER
        display_board
        check_win
        
        if [ "$WIN" == "1" ] ; then
            echo "$USER won"
        fi
        
        ((COUNT+=1))
        tmp=$USER
        USER=$SECOND_USER
        SECOND_USER=$tmp
    else
        echo "This field is occured. Try again."
    fi
done

if [ "$WIN" == "0" ] ; then
    echo "Tie"
fi