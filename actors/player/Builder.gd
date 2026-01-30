extends Actor

func _on_nav_reached_destination() -> void:
	GameManager.tile_array[start_index].start = false
	GameManager.tile_array[end_index].end = false
	GameManager.tile_array[end_index].build_tower()
