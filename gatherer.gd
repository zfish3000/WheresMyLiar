extends Node3D

func setup(start_index,end_index):
	$nav.setup(start_index,end_index)
	global_position = GameManager.tile_array[start_index].position

#
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("step"):
		$nav.new_turn()


	


func _on_nav_moved() -> void:
	var current_tile = GameManager.tile_array[$nav.complete_path[$nav.current_path_index]]
	current_tile.add_resources()
