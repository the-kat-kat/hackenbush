extends AnimatedSprite2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String

@onready var edges: Array[Node] = get_parent().get_node("Hackenbush").get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.demo_now.connect(demo)
	start_dialogue()

func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)

func demo():
	await get_tree().create_timer(1).timeout
	# cut 2-1 / index 6
	select_edge(6)
			
	print("cut 6")
			
	await get_tree().create_timer(3).timeout
	# cut 4-3 / index 3
	select_edge(3)
			
	await get_tree().create_timer(3).timeout
	# cut 5-4 / index 2
	select_edge(2)
			
	await get_tree().create_timer(3).timeout
	# cut 0-1 / index 0
	select_edge(0)
			
	await get_tree().create_timer(3).timeout
	# cut 0-5 / index 1
	select_edge(1)

func select_edge(index: int):
	print("selecting edge: ", index)
	for n in edges.size():
		if n == index:
			edges[n].chosen()
		else:
			edges[n].not_chosen()
