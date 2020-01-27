#!/bin/bash -x
echo "Welcome to Gambling Simulation"

#CONSTANTS
BET=1

#VARIABLES
stake=100

if [ $((RANDOM%2)) -eq 1 ]
then
	echo "Won Bet"
	stake=$(($stake+$BET))
else
	echo "Lose Bet"
	stake=$(($stake-$BET))
fi
