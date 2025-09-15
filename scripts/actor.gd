#
#extends Node3D
#class_name Actor
#
#@export var destination: Hex
#var complete_path: Array = []
#var current_path_index: int = 0
#var moving: bool = false
#var sprite: SpriteFrames
#const GRID_WIDTH = 100
#
## NEW: Accept setup externally
#func _ready() -> void:
	#if sprite != null:
		#$AnimatedSprite3D.sprite_frames = sprite
	#else:
		#pass
#
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("step"):
		#new_turn()
#
#func setup(start_index: int, end_index: int) -> void:
	#global_position = GameManager.tile_array[start_index].position
	#destination = GameManager.tile_array[end_index]
	#if destination.found == false:
		#print("Oh NO")
		#queue_free()
	#if destination.type == 3:
		#print("Oh NO")
		#queue_free()
	#complete_path = find_path(start_index, end_index)
	#print(complete_path)
	#print(self)
	#print(global_position)
#
#
#func new_turn() -> void:
	#print(self)
	#if moving or current_path_index >= complete_path.size():
		#return
#
	#var next_index = complete_path[current_path_index]
	#var next_tile = GameManager.tile_array[next_index]
	#current_path_index += 1
	#moving = true
#
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "global_position", next_tile.position, 0.2)
	#tween.finished.connect(func(): moving = false)
	#if current_path_index == complete_path.size():
		#_reached_destination()
#
#func _reached_destination():
	#print("Reached destination!")
	#destination.build_lookout()
	#var tween = create_tween()
	#tween.tween_property($AnimatedSprite3D,'scale',0,0.1)
	#queue_free()
#
#func get_neighbors(index: int) -> Array:
	#var neighbors = []
#
	#var up = index + GRID_WIDTH
	#var down = index - GRID_WIDTH
	#var left = index - 1
	#var right = index + 1
#
	#var max_index = GameManager.tile_array.size() - 1
#
	#if up <= max_index: #and GameManager.walk_array[up]:
		#neighbors.append(up)
	#if down >= 0: # and GameManager.walk_array[down]:
		#neighbors.append(down)
	#if left % GRID_WIDTH != GRID_WIDTH - 1: # and left >= 0 and GameManager.walk_array[left]:
		#neighbors.append(left)
	#if right % GRID_WIDTH != 0: # and right <= max_index and GameManager.walk_array[right]:
		#neighbors.append(right)
#
	#return neighbors
#
#func find_path(start_index: int, goal_index: int) -> Array:
	#var queue = [start_index]
	#var came_from = {}
	#came_from[start_index] = null
#
	#while queue.size() > 0:
		#var current = queue.pop_front()
#
		#if current == goal_index:
			#break
#
		#for neighbor in get_neighbors(current):
			#if not came_from.has(neighbor):
				#queue.append(neighbor)
				#came_from[neighbor] = current
#
	## Reconstruct path
	#var current = goal_index
	#var path = []
#
	#while current != null:
		#path.insert(0,current)
		#current = came_from.get(current, null)
#
	## Skip the first tile (start tile)
	#if path.size() > 0 and path[0] == start_index:
		#path.remove_at(0)
#
	#return path
