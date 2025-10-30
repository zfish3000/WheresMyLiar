extends Node3D
var current_id = 5
@export var actor_scene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var rng = randi_range(1,8)
	var destination = 1
	
	match rng:
		1:
			destination = current_id - 1
		2:
			destination = current_id - 101
		3:
			destination = current_id + 99
		4:
			destination = current_id + 1
		5:
			destination = current_id - 99
		6:
			destination = current_id + 101
		7:
			destination = current_id + 100
		8:
			destination = current_id - 100
		
	print(destination)
	var actor = actor_scene.instantiate()
	actor.setup(current_id, destination)
	actor.build_camp = false
	add_child(actor)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
