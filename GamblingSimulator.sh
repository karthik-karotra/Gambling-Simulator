#!/bin/bash -x
echo "Welcome to Gambling Simulation"

#CONSTANTS
BET=1
MINIMUMLIMIT=50
MAXIMUMLIMIT=150

#VARIABLES
stake=100

while [[ $stake -ne $MINIMUMLIMIT && $stake -ne $MAXIMUMLIMIT ]]
do
	if [ $((RANDOM%2)) -eq 1 ]
	then
		stake=$(($stake+$BET))
	else
		stake=$(($stake-$BET))
	fi
done

if [ $stake -eq $MINIMUMLIMIT ]
then
	echo "You have lost 50% of your daily stake.Its better you resign for the day"
else
	echo "Bravo!!! You reached your goal. "
fi
