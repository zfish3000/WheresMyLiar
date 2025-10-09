extends Node3D

var end_index_mem

func setup(start_index,end_index):
	$nav.recall = true
	$nav.setup(start_index,end_index)
	global_position = GameManager.tile_array[start_index].position
	end_index_mem = end_index
	global_position = GameManager.tile_array[start_index].position

#
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("step"):
		$nav.new_turn()


	


func _on_nav_moved() -> void:
	var current_tile = GameManager.tile_array[$nav.complete_path[$nav.current_path_index-1]]
	current_tile.add_resources()
	


func _on_nav_reached_destination() -> void:
	setup(end_index_mem,GameManager.base_id)
