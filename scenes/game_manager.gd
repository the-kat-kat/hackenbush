extends Node

var player_1_points: int = 0
var player_2_points: int = 0

var current_player: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func inc_points(player_num: int):
	if player_num == 1:
		player_1_points +=1
	elif player_num ==2:
		player_2_points +=1
		
func inc_player():
	if current_player == 1:
		current_player = 2
	else:
		current_player = 1
