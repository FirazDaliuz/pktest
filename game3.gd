extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var debugs = 0
var states = "bet"
onready var first_play = global.first_play
var player_chips
var player_playing = true
var dealer_playing = false
var deck
var player_hand
var dealer_hand
var dats=0
var daz=0
var testt
var tests
var p_score
var d_score
var game
var sprite = global.sprite

class Card:
	
	var rank
	var suit
	
	func _init(suit,rank):
		self.rank = rank
		self.suit = suit
	
	func string():
		return str(self.rank +" "+ self.suit)

class Deck:
	
	var suits = global.suits
	var ranks = global.ranks
	var re_rank
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
	var values = global.valuez
	var datt
	
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
		
	func discard(string):
		datt = self.values.get(string)
		self.value -= datt
		if string == 'Ace':
			self.aces -= 1
			
class evaluate:
	
 var face_values = global.valuez
	
	
	func _init():
		pass
	
	func value(card):
		if card in face_values:
			return face_values[card]
		else:
			return int(card)
		pass
	
	func valhand(hand):
		var vhand = []
		var dat
		for i in range(5):
			dat = hand[i].split(" ",1)
			vhand.append(value(dat[0]))
		vhand.sort()
		vhand.invert()
		#print(vhand)
		return vhand
		pass
	
	func suithand(hand):
		var suithand = []
		for i in range(5):
			suithand.append(hand[i].right(hand[i].length()-1))
		return suithand
		pass
		
	func onepair(hand):
		var vhand = valhand(hand)
		var pairvalue = []
		for i in vhand:
			if vhand.count(i)==2:
				pairvalue.append(i)
		if pairvalue.size()!=2:
			return false
		for i in pairvalue:
			vhand.erase(i)
		pairvalue.sort()
		return pairvalue+vhand
		
	func twopair(hand):
		var vhand = valhand(hand)
		var pairvalue = []
		for i in vhand:
			if vhand.count(i)==2:
				pairvalue.append(i)
		if pairvalue.size()!=4:
			return false
		for i in pairvalue:
			vhand.erase(i)
		pairvalue.sort()
		return pairvalue+vhand
		
	func threekind(hand):
		var vhand = valhand(hand)
		var pairvalue = []
		for i in vhand:
			if vhand.count(i)==3:
				pairvalue.append(i)
		if pairvalue.size()!=3:
			return false
		for i in pairvalue:
			vhand.erase(i)
		pairvalue.sort()
		return pairvalue+vhand
		
	func straight(hand):
		var vhand = valhand(hand)
		vhand.invert()
		if vhand==range(vhand[0],vhand[0]+5):
			return [vhand[0]+5]
		
	func flush(hand):
		var vhand = valhand(hand)
		var shand = suithand(hand)
		if shand.count(shand[0])==5:
			return vhand
		else:
			return false
	
	func fullhouse(hand):
		if threekind(hand) and onepair(hand):
			return [threekind(hand)[0],onepair(hand)[0]]
		else:
			return false
	
	func fourkind(hand):
		var vhand = valhand(hand)
		var pairvalue = []
		for i in vhand:
			if vhand.count(i)==4:
				pairvalue.append(i)
		if pairvalue.size()!=4:
			return false
		for i in pairvalue:
			vhand.erase(i)
		pairvalue.sort()
		return pairvalue+vhand
	
	func straightflush(hand):
		if straight(hand) and flush(hand):
			return straight(hand)
		else:
			return false
			
	func royal(hand):
		if straightflush(hand) and valhand(hand)[4] == 10:
			return true
		
	func go(hand):
		if royal(hand):
			return [10,10]
			pass
		elif straightflush(hand):
			return [9,straightflush(hand)]
			pass
		elif fourkind(hand):
			return [8,fourkind(hand)]
			pass
		elif fullhouse(hand):
			return [7,fullhouse(hand)]
			pass
		elif flush(hand):
			return [6,flush(hand)]
			pass
		elif straight(hand):
			return [5,straight(hand)]
			pass
		elif threekind(hand):
			return [4,threekind(hand)]
			pass
		elif twopair(hand):
			return [3,twopair(hand)]
			pass
		elif onepair(hand):
			return [2,onepair(hand)]
			pass
		else:
			return [1,valhand(hand)]
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

func showc(player,dealer):
	$dcard1.show()
	$dcard2.show()
	$dcard3.show()
	$dcard4.show()
	$dcard5.show()
	$pcard1.texture=load(str(sprite[player.cards[0]]))
	$pcard2.texture=load(str(sprite[player.cards[1]]))
	$pcard3.texture=load(str(sprite[player.cards[2]]))
	$pcard4.texture=load(str(sprite[player.cards[3]]))
	$pcard5.texture=load(str(sprite[player.cards[4]]))
	$pcard1.show()
	$pcard2.show()
	$pcard3.show()
	$pcard4.show()
	$pcard5.show()

func showa(player,dealer):
	$dcard1.texture=load(str(sprite[dealer.cards[0]]))
	$dcard2.texture=load(str(sprite[dealer.cards[1]]))
	$dcard3.texture=load(str(sprite[dealer.cards[2]]))
	$dcard4.texture=load(str(sprite[dealer.cards[3]]))
	$dcard5.texture=load(str(sprite[dealer.cards[4]]))
	$dcard1.show()
	$dcard2.show()
	$dcard3.show()
	$dcard4.show()
	$dcard5.show()
	$pcard1.texture=load(str(sprite[player.cards[0]]))
	$pcard2.texture=load(str(sprite[player.cards[1]]))
	$pcard3.texture=load(str(sprite[player.cards[2]]))
	$pcard4.texture=load(str(sprite[player.cards[3]]))
	$pcard5.texture=load(str(sprite[player.cards[4]]))
	$pcard1.show()
	$pcard2.show()
	$pcard3.show()
	$pcard4.show()
	$pcard5.show()

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

func result(score_p,score_d,chips):
	var hand_names = {1:'high card', 2:'one pair', 3:'two pair', 4:'three of a kind', 5:'a straight', 6:'a flush', 7:'a full house', 8:'four of a kind', 9:'a straight flush', 10:'a royal flush'}
	$ptype_hand.text = str(hand_names[score_p[0]])
	$dtype_hand.text = str(hand_names[score_d[0]])
	if score_p[0] > score_d[0]:
		player_win(chips)
	elif score_d[0] > score_p[0]:
		player_busts(chips)
	else:
		var tiebp = score_p[1]
		var tiebd = score_d[1]
		if tiebp > tiebd:
			player_win(chips)
		elif tiebd > tiebp:
			player_busts(chips)
		else:
			tie()
	first_play = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print(first_play)
	$pcard1.hide()
	$pcard2.hide()
	$pcard3.hide()
	$pcard4.hide()
	$pcard5.hide()
	$dcard1.hide()
	$dcard2.hide()
	$dcard3.hide()
	$dcard4.hide()
	$dcard5.hide()
	$dtype_hand.text = ""
	$ptype_hand.text = ""
	$pussy.text = ""
	debug()
	deck = Deck.new()
	deck.shuffle()
	player_hand = Hand.new()
	for i in range(5):
		player_hand.add_card(deck.deal())
	dealer_hand = Hand.new()
	for i in range(5):
		dealer_hand.add_card(deck.deal())
	player_chips = Chips.new(first_play)
	$balance.text = str(player_chips.total)
	game = evaluate.new()
	pass # Replace with function body.

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
			#testt = test_player.cards[0].split(" ",1)
			#print(testt[0])
			tests = test_player.cards.size()
			for card in test_player.cards:
				#print(card)
				$debug/txt/txt.text += str(card)+"\n"
				testt = card.split(" ",1)
				test_player.discard(testt[0])
			pass
			test_player.cards.remove(0)
			test_player.cards.remove(0)
			$debug/txt/txt.text +="\n\n\n"
			test_player.add_card(test_deck.deal())
			test_player.add_card(test_deck.deal())
			for card in test_player.cards:
				#print(card)
				$debug/txt/txt.text += str(card)+"\n"
			pass
		elif debugs == 3:
			test_deck.shuffle()
			var test_player = Hand.new()
			var test_eval = evaluate.new()
			#print(test_deck.deal())
			#$debug/txt/txt.text = test_deck.deal()
			for i in range(5):
				test_player.add_card(test_deck.deal())
			#var jdat = ['Ace S','King S','Queen S','Jack S','Ten S']
			print(str(test_eval.go(test_player.cards)))
	else:
		remove_child($debug)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if states == "bet":
		$bet.show()
		$discard.hide()
		$fold.hide()
		$stand.hide()
		$c1.hide()
		$c2.hide()
		$c3.hide()
		$c4.hide()
		$c5.hide()
	elif states == "discard":
		remove_child($bet)
		$discard.show()
		$fold.hide()
		$stand.hide()
		$c1.show()
		$c2.show()
		$c3.show()
		$c4.show()
		$c5.show()
	elif states == "staold":
		remove_child($discard)
		$fold.show()
		$stand.show()
		remove_child($c1)
		remove_child($c2)
		remove_child($c3)
		remove_child($c4)
		remove_child($c5)
	else:
		remove_child($stand)
		remove_child($fold)
	pass


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_restart_pressed():
	global.money = player_chips.total
	queue_free()
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_bet_pressed():
	player_chips.bet = get_node("betnum").text
	player_chips.bet = int(player_chips.bet)
	if player_chips.bet <= player_chips.total:
		states = "discard"
		if first_play == false:
			_ready()
		showc(player_hand,dats)
		#print(int(player_chips.bet))
	else:
		$pussy.text="Not Enough"
	pass # Replace with function body.


func _on_discard_pressed():
	var datq
	var numdat = 0
	if $c5.pressed:
		player_hand.cards.erase(player_hand.cards[4])
		numdat += 1
	if $c4.pressed:
		player_hand.cards.erase(player_hand.cards[3])
		numdat += 1
	if $c3.pressed:
		player_hand.cards.erase(player_hand.cards[2])
		numdat += 1
	if $c2.pressed:
		player_hand.cards.erase(player_hand.cards[1])
		numdat += 1
	if $c1.pressed:
		player_hand.cards.erase(player_hand.cards[0])
		numdat += 1
	if numdat !=0:
		for i in range(numdat):
			player_hand.add_card(deck.deal())
	showc(player_hand,dealer_hand)
	states = "staold"
	pass # Replace with function body.


func _on_fold_pressed():
	player_busts(player_chips)
	$balance.text = str(player_chips.total)
	global.first_play = false
	states = "x"
	pass # Replace with function body.


func _on_stand_pressed():
	p_score = game.go(player_hand.cards)
	d_score = game.go(dealer_hand.cards)
	showa(player_hand,dealer_hand)
	result(p_score,d_score,player_chips)
	$balance.text = str(player_chips.total)
	global.first_play = false
	print(first_play)
	states = "x"
	pass # Replace with function body.
