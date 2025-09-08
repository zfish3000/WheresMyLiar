extends Node

var tile_array = []
var walk_array = []
var score_array = []
var visited_array =[]
var found_array = []
var base_id : int
var base_pos : Vector3
var player_pos = Vector3(0,0,0)
var current_camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if base_id != null:
		pass
