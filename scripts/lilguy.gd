extends Node3D
#
#var tile_array = GameManager.tile_array
#var base_id
#var base_pos
#var start_id
#
#var current_id
#var up_id
#var left_id
#var right_id
#var down_id
#
#var up_pos
#var left_pos
#var right_pos
#var down_pos
#
#var up_score = 1000000000000
#var left_score = 1000000000000
#var right_score = 1000000000000
#var down_score = 1000000000000
#
#var last_id
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#start_id = randi_range(0,10000)
	#position = GameManager.tile_array[start_id]
	#base_id = GameManager.base_id
	#base_pos = GameManager.base_pos
	#
	#current_id = start_id
	#last_id = -1
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#GameManager.visited_array[current_id] = true
	#GameManager.player_pos = position
	#if GameManager.walk_array[current_id-1] == false:
		#$Sprite3D.modulate = Color(0,0,0,255)
	#else:
		#$Sprite3D.modulate = Color(255,255,255,255)
	#
#func pathfind() -> Vector3:



	#OldPathfindingh
	#var up_id = current_id + 100
	#var left_id = current_id - 1
	#var right_id = current_id + 1
	#var down_id = current_id - 100
	#
	#up_pos = GameManager.tile_array[up_id]
	#left_pos = GameManager.tile_array[left_id]
	#right_pos = GameManager.tile_array[right_id]
	#down_pos = GameManager.tile_array[down_id]
	#
	#if up_id >= 0 and GameManager.visited_array[up_id] == false:
		#up_score = abs(up_pos.x - base_pos.x) + abs(up_pos.z - base_pos.z)
		#if up_id == last_id:
			#up_score += 10000
	#elif up_id >= 0 and GameManager.walk_array[up_id] == false:
		#up_score = 100000000000
	#else:
		#up_score = 10000000
		#
	#if left_id >= 0 and GameManager.visited_array[left_id] == false:
		#left_score = abs(left_pos.x - base_pos.x) + abs(left_pos.z - base_pos.z)
		#if left_id == last_id:
			#left_score += 10000
	#elif left_id >= 0 and GameManager.walk_array[left_id] == false:
		#left_score = 100000000000
	#else:
		#left_score = 10000000
		#
	#if right_id >= 0 and GameManager.visited_array[right_id] == false:
		#right_score = abs(right_pos.x - base_pos.x) + abs(right_pos.z - base_pos.z)
		#if right_id == last_id:
			#right_score += 10000
	#elif right_id >= 0 and GameManager.walk_array[right_id] == false:
		#right_score = 100000000000
	#else:
		#right_score = 10000000
		#
	#if down_id >= 0 and GameManager.visited_array[down_id] == false:
		#down_score = abs(down_pos.x - base_pos.x) + abs(down_pos.z - base_pos.z)
		#if down_id == last_id:
			#down_score += 10000
	#elif down_id >= 0 and GameManager.walk_array[down_id] == false:
		#down_score = 100000000000
	#else:
		#down_score = 10000000
	#
	#var decision = min(up_score,right_score,left_score,down_score)
	#
	#print(decision)
	#
	#if decision == up_score:
		#current_id = up_id
		#return up_pos
	#elif decision == right_score:
		#current_id = right_id
		#return right_pos
	#elif decision == left_score:
		#current_id = left_id
		#return left_pos
	#elif decision == down_score:
		#current_id = down_id
		#return down_pos
	#else:
		#return position
	#End Of Old Pathfinding
	
	
	
	#
	#up_id = current_id + 100
	#left_id = current_id - 1
	#right_id = current_id + 1
	#down_id = current_id - 100
	#
	#if up_id >= 0 and up_id <= GameManager.tile_array.size():
		#up_pos = GameManager.tile_array[up_id-1]
		#up_score = GameManager.score_array[up_id]
		#if GameManager.visited_array[up_id-1] == true:
			#up_score += 100000000000
		#if GameManager.walk_array[up_id-1] == false:
			#up_score += 10
	#else:
		#up_pos = Vector3(-1,-1,-1)
	#
	#if left_id >= 0 and left_id <= GameManager.tile_array.size():
		#left_pos = GameManager.tile_array[left_id-1]
		#left_score = GameManager.score_array[left_id]
		#if GameManager.visited_array[left_id-1] == true:
			#left_score += 100000000000
		#if GameManager.walk_array[left_id-1] == false:
			#left_score += 10
	#else:
		#left_pos = Vector3(-1,-1,-1)
	#
	#if right_id >= 0 and right_id <= GameManager.tile_array.size():
		#right_pos = GameManager.tile_array[right_id-1]
		#right_score = GameManager.score_array[right_id]
		#if GameManager.visited_array[right_id-1] == true:
			#right_score += 100000000000
		#if GameManager.walk_array[right_id-1] == false:
			#right_score += 10
	#else:
		#right_pos = Vector3(-1,-1,-1)
	#
	#if down_id >= 0 and down_id <= GameManager.tile_array.size():
		#down_pos = GameManager.tile_array[down_id-1]
		#down_score = GameManager.score_array[down_id]
		#if GameManager.visited_array[down_id-1] == true:
			#down_score += 100000000000
		#if GameManager.walk_array[down_id-1] == false:
			#down_score += 10
	#else:
		#down_pos = Vector3(-1,-1,-1)
	#
	#var win = min(up_score,left_score,right_score,down_score)
	#
	#if win == up_score:
		#if up_id >= 0 and up_id <= GameManager.tile_array.size():
			#GameManager.visited_array[up_id-1] = true
			#current_id = up_id
			#return up_pos
		#else:
			#return position
	#if win == left_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#GameManager.visited_array[left_id-1] = true
			#current_id = left_id
			#return left_pos
		#else:
			#return position
	#if win == right_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#GameManager.visited_array[right_id-1] = true
			#current_id = right_id
			#return right_pos
		#else:
			#return position
	#if win == down_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#GameManager.visited_array[right_id-1] = true
			#current_id = down_id
			#return down_pos
		#else:
			#return position
	#else:
		#return position
	#
#
#
#func _on_timer_timeout() -> void:
	#if current_id != base_id:
		#GameManager.visited_array[current_id-1] = true
		#var new_pos = pathfind()
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", new_pos, 0.2)
#
		#last_id = current_id
		#pass
	#else:
		#return
