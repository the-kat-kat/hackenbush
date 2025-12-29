extends CanvasLayer

@onready var player_1_label: Label = $HBoxContainer/Player1
@onready var player_2_label: Label = $HBoxContainer/Player2

@onready var kat: AnimatedSprite2D = $Kat
@onready var kook: AnimatedSprite2D = $Kook

func _ready():
	GameManager.player_switched.connect(_on_player_switched)
	await get_tree().process_frame 
	player_1_label.pivot_offset = player_1_label.size / 2
	player_1_label.scale = Vector2(1.5, 1.5)
	kat.modulate.a = 1
	kook.modulate.a = 0.2
	
func player_reset():
	player_1_label.scale = Vector2(1,1)
	player_2_label.scale = Vector2(1,1)

func _on_player_switched(new_player_index: int):
	print("player switched", new_player_index)
	if new_player_index == 2:
		kat.modulate.a = 0.2
		kook.modulate.a = 1
		player_2_label.scale = Vector2(1.5,1.5)
		player_2_label.pivot_offset = player_2_label.size/2
		player_1_label.scale = Vector2(1,1)
		player_1_label.pivot_offset = Vector2(0,0)
	elif new_player_index ==1:
		kat.modulate.a = 1
		kook.modulate.a = 0.2
		player_1_label.scale = Vector2(1.5,1.5)
		player_1_label.pivot_offset = player_2_label.size/2
		player_2_label.scale = Vector2(1,1)
		player_2_label.pivot_offset = Vector2(0,0)
		
