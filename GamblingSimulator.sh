#!/bin/bash -x
echo "Welcome to Gambling Simulation"

#CONSTANTS
BET=1
MINIMUM_LIMIT=50
MAXIMUM_LIMIT=150

#VARIABLES
stake=100
winningAmount=0
looseingAmount=0

for((i=1;i<=20;i++))
do
	while [[ $stake -ne $MINIMUM_LIMIT && $stake -ne $MAXIMUM_LIMIT ]]
	do
		if [ $((RANDOM%2)) -eq 1 ]
		then
			stake=$(($stake+$BET))
		else
			stake=$(($stake-$BET))
		fi
	done
	if [ $stake -eq $MINIMUM_LIMIT ]
	then
		loosingAmount=$(($loosingAmount + 50))
		stake=100
	else
		winningAmount=$(($winningAmount+50))
		stake=100
	fi
done
if [ $winningAmount -gt $loosingAmount ]
then
	echo  "You won by $(($winningAmount - $loosingAmount)) Rs in 20 days"
elif [ $winningAmount -lt $loosingAmount ]
then
	echo "You lost by $(($loosingAmount - $winningAmount)) Rs in 20 days"
else
	echo "You neither lose nor win"
fi
