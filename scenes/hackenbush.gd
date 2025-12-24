extends Node2D

var graph = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child.is_in_group("edges"):
			register_edge(child)

func register_edge(edge: Node2D):
	graph[edge] = [edge.node_a, edge.node_b]
	
func handle_cut(edge_node: Node2D):
	print("currting: ", edge_node.name)
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
					
	for edge in graph.keys():
		var nodes = graph[edge]
		var is_safe = false
		for n in nodes:
			if n in grounded:
				is_safe = true
				
			if not is_safe:
				edge.queue_free()
				graph.erase(edge)
				
					
