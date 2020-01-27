#!/bin/bash -x
echo "Welcome to Gambling Simulation"

#CONSTANTS
BET=1
MINIMUM_LIMIT=50
MAXIMUM_LIMIT=150	
WON_COUNT=0
LOST_COUNT=0
NO_OF_DAYS=20

#VARIABLES
stake=100
winningAmount=0
looseingAmount=0

for((i=1;i<=$NO_OF_DAYS;i++))
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
		(( LOST_COUNT++ ))
	else
		winningAmount=$(($winningAmount+50))
		stake=100
		(( WON_COUNT++ ))
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

echo "No of days Gambler won is $WON_COUNT"
echo "No of days Gambler lost is $LOST_COUNT"
echo "Total Amount won is $(($WON_COUNT*50))"
echo "Total amount lost is $(($LOST_COUNT*50))"
