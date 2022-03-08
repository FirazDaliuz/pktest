extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var s = Vector2()


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	s.x = 5
	s.y = 5
	$icon.scale = s
	$icon.offset = s
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_resize_pressed():
	var data = int(get_node("size").get_text())
	s.x = data
	$icon.scale = s
	#$icon.offset = s
	pass # replace with function body
