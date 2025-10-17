#extends Node3D
#class_name Actor
#
#@export var destination : Hex
#
#var reached_destination
#var score_array:Array = []
#var visited_array:Array = []
#var current_id
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#SignalBus.new_turn.connect(new_turn)
	#destination = GameManager.tile_array[randi_range(0,GameManager.tile_array.size())]
	#var current_hex = GameManager.tile_array[randi_range(0,GameManager.tile_array.size())]
	#current_id = current_hex.index
	#position = current_hex.position
	#SignalBus.new_turn.connect(new_turn)
	#for i in GameManager.tile_array:
		#score_array.append(abs(i.position.x - destination.position.x) + abs(i.position.z - destination.position.z))
		#visited_array.append(false)
	#pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#new_turn()
	#
#func new_turn():
	#if position != destination.position:
		#visited_array[current_id-1] = true
		#var new_pos = pathfind()
		#var tween = get_tree().create_tween()
		#tween.tween_property(actor, "position", new_pos, 0.2)
		#pass
	#else:
		#_reached_destination()
	#pass
	#
#
#func _reached_destination():
	#pass
#
#func pathfind() -> Vector3:
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
	#up_id = current_id + 100
	#left_id = current_id - 1
	#right_id = current_id + 1
	#down_id = current_id - 100
	#
	#if up_id >= 0 and up_id <= GameManager.tile_array.size():
		#up_pos = GameManager.tile_array[up_id-1].position
		#up_score = score_array[up_id]
		#if visited_array[up_id-1] == true:
			#up_score += 100000000000
		#if GameManager.walk_array[up_id-1] == false:
			#up_score += 10
	#else:
		#up_pos = Vector3(-1,-1,-1)
	#
	#if left_id >= 0 and left_id <= GameManager.tile_array.size():
		#left_pos = GameManager.tile_array[left_id-1].position
		#left_score = score_array[left_id]
		#if visited_array[left_id-1] == true:
			#left_score += 100000000000
		#if GameManager.walk_array[left_id-1] == false:
			#left_score += 10
	#else:
		#left_pos = Vector3(-1,-1,-1)
	#
	#if right_id >= 0 and right_id <= GameManager.tile_array.size():
		#right_pos = GameManager.tile_array[right_id-1].position
		#right_score = score_array[right_id]
		#if visited_array[right_id-1] == true:
			#right_score += 100000000000
		#if GameManager.walk_array[right_id-1] == false:
			#right_score += 10
	#else:
		#right_pos = Vector3(-1,-1,-1)
	#
	#if down_id >= 0 and down_id <= GameManager.tile_array.size():
		#down_pos = GameManager.tile_array[down_id-1].position
		#down_score = score_array[down_id]
		#if visited_array[down_id-1] == true:
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
			#visited_array[up_id-1] = true
			#current_id = up_id
			#return up_pos
		#else:
			#return position
	#if win == left_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#visited_array[left_id-1] = true
			#current_id = left_id
			#return left_pos
		#else:
			#return position
	#if win == right_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#visited_array[right_id-1] = true
			#current_id = right_id
			#return right_pos
		#else:
			#return position
	#if win == down_score:
		#if left_id >= 0 and left_id <= GameManager.tile_array.size():
			#visited_array[right_id-1] = true
			#current_id = down_id
			#return down_pos
		#else:
			#return position
	#else:
		#return position
	#
extends Node3D
class_name nav

@export var destination: Hex
@export var actor : Node3D
var complete_path: Array = []
var current_path_index: int = 0
var moving: bool = false
var sprite: SpriteFrames
var reached_destination_bool= false
var recall = false
const GRID_WIDTH = 100

signal moved
signal reached_destination

func setup(start_index: int, end_index: int) -> void:
	global_position = GameManager.tile_array[start_index].position
	destination = GameManager.tile_array[end_index]
	if destination.found == false:
		print("Oh NO")
		#queue_free()
	if destination.type == 3:
		print("Oh NO")
		#queue_free()
	complete_path = find_path(start_index, end_index)


func new_turn() -> void:
	if moving or current_path_index >= complete_path.size():
		return

	var next_index = complete_path[current_path_index]
	var next_tile = GameManager.tile_array[next_index]
	current_path_index += 1
	moving = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(actor, "global_position", next_tile.position, 0.2)
	tween.finished.connect(func(): moving = false)
	moved.emit()
	if current_path_index == complete_path.size():
		tween.finished.connect(func(): reached_destination.emit())
		if recall == true:
			current_path_index = 0
	

func _reached_destination():
	#print("Reached destination!")
	#destination.build_lookout()
	#var tween = create_tween()
	#tween.tween_property($AnimatedSprite3D,'scale',0,0.1)
	#queue_free()
	reached_destination.emit()

func get_neighbors(index: int) -> Array:
	var neighbors = []

	var up = index + GRID_WIDTH
	var down = index - GRID_WIDTH
	var left = index - 1
	var right = index + 1

	var max_index = GameManager.tile_array.size() - 1

	if up <= max_index: #and GameManager.walk_array[up]:
		neighbors.append(up)
	if down >= 0: # and GameManager.walk_array[down]:
		neighbors.append(down)
	if left % GRID_WIDTH != GRID_WIDTH - 1: # and left >= 0 and GameManager.walk_array[left]:
		neighbors.append(left)
	if right % GRID_WIDTH != 0: # and right <= max_index and GameManager.walk_array[right]:
		neighbors.append(right)

	return neighbors

func find_path(start_index: int, goal_index: int) -> Array:
	var queue = [start_index]
	var came_from = {}
	came_from[start_index] = null

	while queue.size() > 0:
		var current = queue.pop_front()

		if current == goal_index:
			break

		for neighbor in get_neighbors(current):
			if not came_from.has(neighbor):
				queue.append(neighbor)
				came_from[neighbor] = current

	# Reconstruct path
	var current = goal_index
	var path = []

	while current != null:
		path.insert(0,current)
		current = came_from.get(current, null)

	# Skip the first tile (start tile)
	if path.size() > 0 and path[0] == start_index:
		path.remove_at(0)

	return path
