@tool
extends Area2D

@onready var line = $Line2D
@onready var collision = $CollisionPolygon2D

@export_enum("blue", "red", "green") var edge_color: String = "blue"
@export var node_a: int = 0  # Start point 0
@export var node_b: int = 1  # End point

@export var p0 := Vector2(0, 0)
@export var p1 := Vector2(-250, 300)
@export var p2 := Vector2(-574, 600)

func _ready():
	p0 = line.get_point_position(0)
	p1 = line.get_point_position(1)
	p2 = line.get_point_position(2)
	draw_curve()
	
	add_to_group("edges")

func _quadratic_bezier(t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	return q0.lerp(q1, t)

func draw_curve():
	line.clear_points()
	var resolution = 15 
	
	if edge_color == "blue": 
		line.default_color = Color.DODGER_BLUE
	elif edge_color == "red": 
		line.default_color = Color.CRIMSON
	else: 
		line.default_color = Color.PALE_GREEN
	
	for i in range(resolution + 1):
		var t = float(i) / resolution
		var point = _quadratic_bezier(t)
		line.add_point(point)
		print("pt", t, " hi ", point)
		
	
	setup_collision()
	
func setup_collision():
	collision.polygon = PackedVector2Array()
	var thickness = 10.0 
	var points_top = []
	var points_bottom = []
	
	for i in range(line.points.size()):
		var p = line.points[i]
		var dir = Vector2.ZERO
		if i < line.points.size() - 1:
			dir = (line.points[i+1] - p).normalized()
		else:
			dir = (p - line.points[i-1]).normalized()
		
		var normal = Vector2(-dir.y, dir.x) * thickness
		points_top.append(p + normal)
		print("points", p)
		points_bottom.insert(0, p - normal)
		
	collision.polygon = points_top + points_bottom
	collision.scale = line.scale

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print_debug("heyy")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("touched")
		get_parent().handle_cut(self)

func _on_mouse_entered() -> void:
	print_debug("hi there")
