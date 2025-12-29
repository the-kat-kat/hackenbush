extends Node2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String

@export var vertices_holder: Node2D
var vertices: Array[Node]

var graph = {}
var node_graph= {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group("edges"):
			register_edge(child)
			
	vertices = vertices_holder.get_children()

func register_edge(edge: Node2D):
	graph[edge] = [edge.node_a, edge.node_b]
	
	if not node_graph.has(edge.node_a):
		node_graph[edge.node_a]=[]
	if not node_graph.has(edge.node_b):
		node_graph[edge.node_b]=[]
	node_graph[edge.node_a].append(edge.node_b)
	node_graph[edge.node_b].append(edge.node_a)
	
func handle_cut(edge_node: Node2D):
	print("currting: ", edge_node)
	
	var a = edge_node.node_a
	var b = edge_node.node_b
	
	node_graph[a].erase(b)
	node_graph[b].erase(a)
	
	graph.erase(edge_node)
	edge_node.queue_free()
	
	await get_tree().process_frame
	check_floating_edges()
	
func check_floating_edges():
	var grounded = []
	var stack = [0] # 0 is ground
	
	while stack.size()>0:
		var current_node = stack.pop_back()
		if current_node not in grounded:
			grounded.append(current_node)
			
			for edge in graph.keys():
				var nodes = graph[edge]
				if current_node in nodes:
					var next_node = nodes[1] if nodes[0] == current_node else nodes[0]
					stack.append(next_node)
					
	for i in range(vertices.size()):
		if i in grounded:
			vertices[i].visible = true
		else:
			vertices[i].visible = false
					
	for edge in graph.keys():
		var nodes = graph[edge]
		
		var is_safe = false
		for n in nodes:
			if n in grounded:
				is_safe = true
				
			if not is_safe:
				edge.queue_free()
				graph.erase(edge)
				
					
	if graph.size() == 0:
		if GameManager.current_player == 1:
			GameManager.player_1_total_points +=1
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "player_1")
		elif GameManager.current_player == 2:
			GameManager.player_2_total_points +=1
			DialogueManager.show_example_dialogue_balloon(dialogue_resource, "player_2")
		GameManager.update_levels_points()
	else:
		print("inc")
		GameManager.inc_player()
