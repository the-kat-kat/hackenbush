extends AnimatedSprite2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_dialogue()


func start_dialogue():
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
