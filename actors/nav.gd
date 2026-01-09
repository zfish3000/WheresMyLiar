extends Node3D
class_name nav

@export var destination: Hex
@export var actor : Node3D
var complete_path: Array = []
var current_path_index: int = 0
var moving: bool = false
var sprite: SpriteFrames
var reached_destination_bool = false
var recall = false
const GRID_WIDTH = 100

signal moved
signal reached_destination


func setup(start_index: int, end_index: int) -> void:
	global_position = GameManager.tile_array[start_index].position
	destination = GameManager.tile_array[end_index]
	if destination.found == false:
		print("Oh NO")
		get_parent().queue_free()
	if destination.type == 3:
		print("Oh NO")
		get_parent().queue_free()
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
	reached_destination.emit()


func get_neighbors(index: int) -> Array:
	var neighbors = []
	var up = index + GRID_WIDTH
	var down = index - GRID_WIDTH
	var left = index - 1
	var right = index + 1
	var max_index = GameManager.tile_array.size() - 1
	
	# Only add walkable neighbors
	if up <= max_index and is_walkable(up):
		neighbors.append(up)
	if down >= 0 and is_walkable(down):
		neighbors.append(down)
	if left % GRID_WIDTH != GRID_WIDTH - 1 and left >= 0 and is_walkable(left):
		neighbors.append(left)
	if right % GRID_WIDTH != 0 and right <= max_index and is_walkable(right):
		neighbors.append(right)
	
	return neighbors


# Check if a tile is walkable or solid
func is_walkable(index: int) -> bool:
	# Check if tile exists
	if index < 0 or index >= GameManager.tile_array.size():
		return false
	
	var tile = GameManager.tile_array[index]

	
	if !tile.walkable:
		return false
	
	return true


# Heuristic function (Manhattan distance for grid)
func heuristic(index_a: int, index_b: int) -> float:
	var a_x = index_a % GRID_WIDTH
	var a_y = index_a / GRID_WIDTH
	var b_x = index_b % GRID_WIDTH
	var b_y = index_b / GRID_WIDTH
	
	return abs(a_x - b_x) + abs(a_y - b_y)


# A* pathfinding
func find_path(start_index: int, goal_index: int) -> Array:
	# Priority queue: [f_score, index]
	var open_set = [[0.0, start_index]]
	var came_from = {}
	var g_score = {}
	var f_score = {}
	
	g_score[start_index] = 0.0
	f_score[start_index] = heuristic(start_index, goal_index)
	
	while open_set.size() > 0:
		# Get node with lowest f_score
		open_set.sort_custom(func(a, b): return a[0] < b[0])
		var current = open_set.pop_front()[1]
		
		# Goal reached
		if current == goal_index:
			return reconstruct_path(came_from, current, start_index)
		
		# Check all neighbors
		for neighbor in get_neighbors(current):
			# Cost to move to neighbor (1.0 for adjacent tiles)
			var tentative_g_score = g_score[current] + 1.0
			
			# If this path to neighbor is better than any previous one
			if not g_score.has(neighbor) or tentative_g_score < g_score[neighbor]:
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				f_score[neighbor] = tentative_g_score + heuristic(neighbor, goal_index)
				
				# Add to open set if not already there
				var in_open_set = false
				for item in open_set:
					if item[1] == neighbor:
						in_open_set = true
						break
				
				if not in_open_set:
					open_set.append([f_score[neighbor], neighbor])
	
	# No path found
	print("No path found from ", start_index, " to ", goal_index)
	return []


func reconstruct_path(came_from: Dictionary, current: int, start_index: int) -> Array:
	var path = []
	while current != start_index:
		path.insert(0, current)
		current = came_from[current]
	return path
