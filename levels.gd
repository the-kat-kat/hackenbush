extends Node2D

@export var player_1_label: Label
@export var player_2_label: Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.update_points.connect(update_points)
	pass

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level2.tscn")


func _on_level_3_pressed() -> void:
	pass # Replace with function body.


func _on_level_4_pressed() -> void:
	pass # Replace with function body.


func _on_level_5_pressed() -> void:
	pass # Replace with function body.


func _on_level_6_pressed() -> void:
	pass # Replace with function body.
	
func update_points():
	player_1_label.text = "Player 1: " + str(GameManager.player_1_total_points)
	player_2_label.text = "Player 2: " + str(GameManager.player_2_total_points)
