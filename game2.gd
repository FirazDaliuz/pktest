extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var game_time = get_node("game-time")
var debugs = 0
var states = "bet"
var first_play = global.first_play
var player_chips
var player_playing = true
var dealer_playing = false
var deck
var player_hand
var dealer_hand
var dats=0

class Card:
	
	var rank
	var suit
	
	func _init(suit,rank):
		self.rank = rank
		self.suit = suit
	
	func string():
		return str(self.rank + " of " + self.suit)

class Deck:
	
	var suits = global.suits
	var ranks = global.ranks
	var deck = []
	var suit
	var rank
	var single_card
	
	func _init():
		for suit in suits:
			for rank in ranks:
				self.deck.append(Card.new(suit,rank))
		#self.deck.pop_back()
	
	func string():
		var deck_comp = ''
		for card in self.deck:
			deck_comp += '\n'+card.string()
		return 'The deck has:' +deck_comp
	
	func shuffle():
		randomize()
		self.deck.shuffle()
		
	func deal():
		single_card = self.deck.pop_back()
		#print(single_card.string())
		return single_card

class Hand:
	
	var cards = []
	var value
	var aces
	var values = global.values
	
	func _init():
		self.cards = []
		self.value = 0
		self.aces = 0

	func add_card(card):
		self.cards.append(card.string())
		self.value += self.values[card.rank]
		if card.rank == 'Ace':
			self.aces += 1

	func adjust_for_ace():
		while self.value > 21 and self.aces:
			self.value -= 10
			self.aces -= 1
		pass

class Chips:
	
	var total
	var bet
	
	func _init(stat):
		self.total = global.money
		self.bet = 0
		pass
		
	func win_bet():
		self.total += self.bet
		pass
		
	func lose_bet():
		self.total -= self.bet
		pass

func hit(deck,hand):
	hand.add_card(deck.deal())
	hand.adjust_for_ace()
	pass
	
func dealer_hit_or_stand(deck,hand,loop):
	if loop < 17:
		showc(player_hand,dats)
		hit(deck,hand)
	elif loop >= 17:
		showc(player_hand,dealer_hand)
		$pussy.text = "Show time"
		dealer_playing = false
	pass

func showc(player,dealer):
	$dealer_hand.text = ""
	$player_hand.text = ""
	for dcard in dealer.cards:
		$dealer_hand.text += str(dcard)+ " "
	for pcard in player.cards:
		$player_hand.text += str(pcard) + " "
	pass
	
func player_busts(chips):
	$pussy.text = "Player busts"
	chips.lose_bet()
	pass

func player_win(chips):
	$pussy.text = "Player win"
	chips.win_bet()
	pass

func dealer_busts(chips):
	$pussy.text = "Dealer busts"
	chips.win_bet()
	pass

func dealer_win(chips):
	$pussy.text = "Dealer win"
	chips.lose_bet()
	pass

func tie():
	$pussy.text = "Tie"
	pass
	
func dat():
	dats = dealer_hand
	dats.cards[0] = "?"
	pass

func go():
	if player_hand.value > 21:
		player_busts(player_chips)
		$hit.hide()
		$stand.hide()
	elif player_hand.value <= 21:
		if dealer_playing == true:
			while dealer_hand.value < 17:
				dealer_hit_or_stand(deck,dealer_hand,dealer_hand.value)
				dat()
			if dealer_hand.value > 21:
				dealer_busts(player_chips)
			elif dealer_hand.value > player_hand.value:
				dealer_win(player_chips)
			elif dealer_hand.value < player_hand.value:
				player_win(player_chips)
			else:
				tie()
		$balance.text = str(player_chips.total)
		states = "bet"
		first_play = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print(first_play)
	$dealer_hand.text = ""
	$player_hand.text = ""
	$pussy.text = ""
	debug()
	deck = Deck.new()
	deck.shuffle()
	player_hand = Hand.new()
	player_hand.add_card(deck.deal())
	player_hand.add_card(deck.deal())
	dealer_hand = Hand.new()
	dealer_hand.add_card(deck.deal())
	dealer_hand.add_card(deck.deal())
	dat()
	if first_play == true:
		player_chips = Chips.new(first_play)
	$balance.text = str(player_chips.total)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$timer.set_text(str(int(game_time.get_time_left())))
	if states == "bet":
		$bet.show()
		$hit.hide()
		$stand.hide()
	else:
		$bet.hide()
		$hit.show()
		$stand.show()
	pass

func debug():
	if debugs > 0:
		var test_deck = Deck.new()
		if debugs == 1:
			#print(test_deck.string())
			$debug/txt/txt.text = test_deck.string()
		elif debugs == 2:
			test_deck.shuffle()
			var test_player = Hand.new()
			#print(test_deck.deal())
			#$debug/txt/txt.text = test_deck.deal()
			test_player.add_card(test_deck.deal())
			test_player.add_card(test_deck.deal())
			#print(test_player.cards)
			for card in test_player.cards:
				#print(card.string())
				$debug/txt/txt.text += card.string()+"\n"
			pass
	else:
		remove_child($debug)
	pass

func _on_bet_pressed():
	player_chips.bet = get_node("betnum").text
	player_chips.bet = int(player_chips.bet)
	if player_chips.bet <= player_chips.total:
		states = "x"
		if first_play == false:
			_ready()
		showc(player_hand,dats)
		#print(int(player_chips.bet))
	else:
		$pussy.text="Not Enough"
	pass # Replace with function body.

func _on_hit_pressed():
	hit(deck,player_hand)
	showc(player_hand,dats)
	pass # Replace with function body.

func _on_stand_pressed():
	$pussy.text = "Dealer Turn"
	player_playing = false
	dealer_playing = true
	$hit.hide()
	$stand.hide()
	go()
	pass # Replace with function body.

func _on_restart_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _on_gametime_timeout():
	$bet.hide()
	$hit.hide()
	$stand.hide()
	pass # Replace with function body.
