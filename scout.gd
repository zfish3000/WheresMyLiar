extends Actor

	
func _on_nav_reached_destination() -> void:
	GameManager.tile_array[end_index].reveal(5)
