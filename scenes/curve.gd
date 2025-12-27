@tool
extends Area2D

@onready var line = $Line2D
@onready var collision = $CollisionPolygon2D

@export var resolution := 15
@export var curved = false
@export_enum("blue", "red", "green") var edge_color: String = "blue"
@export var node_a: int = 0
@export var node_b: int = 1

@export var p0 : Vector2	
@export var p1 : Vector2
@export var p2 : Vector2
		

func _ready():
	p0 = line.get_point_position(0)
	p1 = line.get_point_position(1)
	
	if line.points.size() == 2:
		p2 = line.get_point_position(1)
	elif line.points.size() >= 3:
		p2 = line.get_point_position(2)
	draw_curve()
	
	add_to_group("edges")

func _quadratic_bezier(t: float) -> Vector2:
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	return q0.lerp(q1, t)

func draw_curve():
	if not line:
		return
		
	line.clear_points()
		
	if edge_color == "blue": 
		line.default_color = Color.DODGER_BLUE
	elif edge_color == "red": 
		line.default_color = Color.CRIMSON
	else: 
		line.default_color = Color.PALE_GREEN
		
	if Engine.is_editor_hint():
		line.clear_points()
		line.add_point(p0)
		line.add_point(p1)
		if curved:
			line.add_point(p2)
	else:
		if curved:
			for i in range(resolution + 1):
				var t = float(i) / resolution
				var point = _quadratic_bezier(t)
				line.add_point(point)
				print("pt", t, " hi ", point)
			setup()
		else:
			line.add_point(p0)
			line.add_point(p1)
			setup()
			
func setup_line():
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
		collision = shape
	
func setup():
	collision.polygon = PackedVector2Array()
	var thickness = 20.0 
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
	collision.transform = line.transform

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print_debug("heyy")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("touched")
		get_parent().handle_cut(self)

func _on_mouse_entered() -> void:
	print_debug("hi there")
	
