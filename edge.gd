extends Area2D

@export_enum("blue", "red", "green") var edge_color: String = "blue"
@export var node_a: int = 0  # Start point 0
@export var node_b: int = 1  # End point

@onready var line = $Line2D
@onready var collision = $CollisionShape2D


func _ready():
	add_to_group("edges")
	setup()

func setup():
	if edge_color == "blue": 
		line.default_color = Color.DODGER_BLUE
	elif edge_color == "red": 
		line.default_color = Color.CRIMSON
	else: 
		line.default_color = Color.PALE_GREEN
	
	if line.points.size() >= 2:
		var shape = SegmentShape2D.new()
		shape.a = line.points[0]
		shape.b = line.points[1]

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if (GameManager.current_player == 1 and edge_color == "blue") or (GameManager.current_player == 2 and edge_color == "red"):
			print("rwrong color")
			return
		get_parent().handle_cut(self)
