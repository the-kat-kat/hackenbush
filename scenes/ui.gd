extends CanvasLayer

@onready var player_1_label: Label = $HBoxContainer/Player1
@onready var player_2_label: Label = $HBoxContainer/Player2

func _ready():
	GameManager.player_switched.connect(_on_player_switched)
	await get_tree().process_frame 
	player_1_label.pivot_offset = player_1_label.size / 2
	player_1_label.scale = Vector2(1.5, 1.5)

func _on_player_switched(new_player_index: int):
	print("switching to ",  new_player_index)
	if new_player_index == 2:
		player_2_label.scale = Vector2(1.5,1.5)
		player_2_label.pivot_offset = player_2_label.size/2
		player_1_label.scale = Vector2(1,1)
		player_1_label.pivot_offset = Vector2(0,0)
	elif new_player_index ==1:
		player_1_label.scale = Vector2(1.5,1.5)
		player_1_label.pivot_offset = player_2_label.size/2
		player_2_label.scale = Vector2(1,1)
		player_2_label.pivot_offset = Vector2(0,0)
