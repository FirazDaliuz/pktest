extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var money = 100
var suits = ['H','D','S','C']
var ranks = ['Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','Jack','Queen','King','Ace']
var rankz = [2,3,4,5,6,7,8,9,10,'Jack','Queen','King','Ace']
var values = {'Two':2,'Three':3,'Four':4,'Five':5,'Six':6,'Seven':7,'Eight':8,'Nine':9,'Ten':10,'Jack':10,'Queen':10,'King':10,'Ace':11}
var valuez = {'Two':2,'Three':3,'Four':4,'Five':5,'Six':6,'Seven':7,'Eight':8,'Nine':9,'Ten':10,'Jack':11,'Queen':12,'King':13,'Ace':14}
var first_play = true
var sprite = {'Two H':'res://resource/cards/heart2.jpg','Three H':'res://resource/cards/heart3.jpg','Four H':'res://resource/cards/heart4.jpg','Five H':'res://resource/cards/heart5.jpg','Six H':'res://resource/cards/heart6.jpg','Seven H':'res://resource/cards/heart7.jpg','Eight H':'res://resource/cards/heart8.jpg','Nine H':'res://resource/cards/heart9.jpg','Ten H':'res://resource/cards/heart10.jpg','Jack H':'res://resource/cards/heart11.jpg','Queen H':'res://resource/cards/heart12.jpg','King H':'res://resource/cards/heart13.jpg','Ace H':'res://resource/cards/heart1.jpg','Two D':'res://resource/cards/diamo2.jpg','Three D':'res://resource/cards/diamo3.jpg','Four D':'res://resource/cards/diamo4.jpg','Five D':'res://resource/cards/diamo5.jpg','Six D':'res://resource/cards/diamo6.jpg','Seven D':'res://resource/cards/diamo7.jpg','Eight D':'res://resource/cards/diamo8.jpg','Nine D':'res://resource/cards/diamo9.jpg','Ten D':'res://resource/cards/diamo10.jpg','Jack D':'res://resource/cards/diamo11.jpg','Queen D':'res://resource/cards/diamo12.jpg','King D':'res://resource/cards/diamo13.jpg','Ace D':'res://resource/cards/diamo1.jpg','Two S':'res://resource/cards/spade2.jpg','Three S':'res://resource/cards/spade3.jpg','Four S':'res://resource/cards/spade4.jpg','Five S':'res://resource/cards/spade5.jpg','Six S':'res://resource/cards/spade6.jpg','Seven S':'res://resource/cards/spade7.jpg','Eight S':'res://resource/cards/spade8.jpg','Nine S':'res://resource/cards/spade9.jpg','Ten S':'res://resource/cards/spade10.jpg','Jack S':'res://resource/cards/spade11.jpg','Queen S':'res://resource/cards/spade12.jpg','King S':'res://resource/cards/spade13.jpg','Ace S':'res://resource/cards/spade1.jpg','Two C':'res://resource/cards/clubs2.jpg','Three C':'res://resource/cards/clubs3.jpg','Four C':'res://resource/cards/clubs4.jpg','Five C':'res://resource/cards/clubs5.jpg','Six C':'res://resource/cards/clubs6.jpg','Seven C':'res://resource/cards/clubs7.jpg','Eight C':'res://resource/cards/clubs8.jpg','Nine C':'res://resource/cards/clubs9.jpg','Ten C':'res://resource/cards/clubs10.jpg','Jack C':'res://resource/cards/clubs11.jpg','Queen C':'res://resource/cards/clubs12.jpg','King C':'res://resource/cards/clubs13.jpg','Ace C':'res://resource/cards/clubs1.jpg'}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#print(ranks.size())
	#print(str(values.get("Two")))
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
