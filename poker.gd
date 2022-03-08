extends Node2D

onready var timer = get_node("timer")
onready var game_time = get_node("game-time")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#var bankBalance = 100
var bankBalance = global.money
var firstCard
var secondCard
var cardValues
var betAmount


func showCard(val):
	var cards = [2,3,4,5,6,7,8,9,10,"J","Q","K","ACE"]
	return cards[val]
	pass

func showBalance():
	$balance.text = str(bankBalance)
	pass

func adjustBalance(amount):
	bankBalance = bankBalance + amount
	showBalance()
	pass

func dealCard():
	randomize()
	var nextCardValue = randi()%13
	return nextCardValue
	pass

func dealCards():
	var cardValues = {
		first = dealCard(),
		second = dealCard()
	}
	$card1.text = str(showCard(cardValues.first))
	$card2.text = str(showCard(cardValues.second))
	print (str(showCard(cardValues.first)))
	print (str(showCard(cardValues.second)))
	$card1.show()
	$card2.show()
	return cardValues
	pass

func getBet():
	var betOK = false
	var betAmount = 0
	while betOK == false:
		var amount = get_node("bet").get_text()
		betAmount = int(amount)
		if betAmount == 0:
			$pussy.show()
			betOK = true
			pass
		if betAmount <= bankBalance:
			betOK = true
		else:
			$pussy.text = "Not Enough"
			$pussy.show()
			pass
		if betOK == true:
			break
	return betAmount
	pass

func playRound(cardValues):
	var playerCard = dealCard()
	firstCard = cardValues.first
	secondCard = cardValues.second
	$card3.text = str(playerCard)
	print (str(playerCard))
	$card3.show()
	var minValue = min(firstCard,secondCard)
	var maxValue = max(firstCard,secondCard)
	if playerCard >= minValue and playerCard <= maxValue:
		$pussy.text = "You Win"
		$pussy.show()
		return true
	else:
		$pussy.text = "You lose"
		$pussy.show()
		return false
	pass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$pussy.hide()
	$card1.hide()
	$card2.hide()
	$card3.hide()
	$balance.text = str(bankBalance)
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$timer.set_text(str(int(game_time.get_time_left())))
	if bankBalance == 0 :
		resetworld()
	pass

func _on_start_pressed():
	$card3.text = ""
	$pussy.text = ""
	cardValues = dealCards()
	betAmount = getBet()
	if betAmount == 0 :
		$pussy.show()
	pass # replace with function body

func _on_re_pressed():
	resetworld()
	pass # replace with function body

func resetworld():
	get_tree().reload_current_scene()
	pass

func _on_gametime_timeout():
	get_node("start").hide()
	pass # replace with function body

func _on_exit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_end_pressed():
	if playRound(cardValues):
		adjustBalance(betAmount)
	else:
		adjustBalance(-betAmount)
	pass # replace with function body
