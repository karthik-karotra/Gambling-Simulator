#!/bin/bash
declare -A checkLuckiestUnluckiest
declare -A winOrLooseDictionary
echo "Welcome to Gambling Simulation"

#VARIABLES
stake=100
winningAmount=0
wonCount=0
lostCount=0
looseingAmount=0
currentAmount=0

#CONSTANTS
PERCENTAGE=50
BET=1
MINIMUM_LIMIT=$(($(($PERCENTAGE*$stake/100)) + $stake))
MAXIMUM_LIMIT=$(($stake - $(($PERCENTAGE*$stake/100))))
NO_OF_DAYS=20

function bet() {
	if [ $((RANDOM%2)) -eq 1 ]
	then
		stake=$(($stake+$BET))
	else
		stake=$(($stake-$BET))
	fi
}

function WinOrLoose() {
	if [ $stake -eq $MINIMUM_LIMIT ]
	then
		loosingAmount=$(($loosingAmount + 50))
		stake=100
		(( lostCount++ ))
		currentAmount=$(($currentAmount-50))
		winOrLooseDictionary[$1]="Lost"
	else
		winningAmount=$(($winningAmount+50))
		stake=100
		(( wonCount++ ))
		currentAmount=$(($currentAmount+50))
		winOrLooseDictionary[$1]="Win"
	fi
}
function playGame() {
	for((i=1;i<=$NO_OF_DAYS;i++))
	do
		while [[ $cashInHand -lt $WINNING_LIMIT && $cashInHand -gt $LOOSING_LIMIT ]]
		do
			bet
		done
		WinOrLoose $i
		amountPerDay[$i]=$currentAmount
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
	echo "Keys : ${!checkLuckiestUnluckiest[@]}"
	echo "Amount per day : ${checkLuckiestUnluckiest[@]}"
	echo "Keys : ${!winOrLooseDictionary[@]}"
	echo "Resign with won or lost : ${winOrLooseDictionary[@]}"
}

function checkGamblerLuck() {
	for i in ${!checkLuckiestUnluckiest[@]}
	do
		echo "$i ${checkLuckiestUnluckiest[$i]}"
	done | sort -k2 $1 | head -1
}

while [ $currentAmount -ge 0 ]
do
	playGame
	echo "Luckiest Day with amount is"
	checkGamblerLuck -rn
	echo "Unluckiest Day with amount is"
	checkGamblerLuck -n
	if [ ${checkLuckiestUnluckiest[20]} -ge 0 ]
	then
		read -p "do you want to continue for next month(y/n): " result
		if [ $result == "y" ]
		then
			echo "next month"
			winningAmount=0
			loosingAmount=0
			wonCount=0
			lostCount=0currentAmount=0
		else
			break
		fi
	fi
done

