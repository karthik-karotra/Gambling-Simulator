#!/bin/bash
declare -A checkLuckiestUnluckiest
echo "Welcome to Gambling Simulation"

#CONSTANTS
BET=1
MINIMUM_LIMIT=50
MAXIMUM_LIMIT=150	
NO_OF_DAYS=20

#VARIABLES
stake=100
winningAmount=0
wonCount=0
lostCount=0
looseingAmount=0
currentAmount=0

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
		(( lostCount++ ))
		currentAmount=$(($currentAmount-50))
	else
		winningAmount=$(($winningAmount+50))
		stake=100
		(( wonCount++ ))
		currentAmount=$(($currentAmount+50))
	fi
	checkLuckiestUnluckiest[$i]=$currentAmount
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

echo "No of days Gambler won is $wonCount"
echo "No of days Gambler lost is $lostCount"
echo "Total Amount won is $winningAmount"
echo "Total amount lost is $loosingAmount"
echo ${!checkLuckiestUnluckiest[@]}
echo ${checkLuckiestUnluckiest[@]}

function checkGamblerLuck() {
	for i in ${!checkLuckiestUnluckiest[@]}
	do
		echo "$i ${checkLuckiestUnluckiest[$i]}"
	done | sort -k2 $1 | head -1
}

echo "Luckiest Day with amount is"
checkGamblerLuck -rn
echo "Unluckiest Day with amount is"
checkGamblerLuck -n
