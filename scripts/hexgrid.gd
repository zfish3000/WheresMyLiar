extends Node3D

const TILE_SIZE := 1.0
const HEX_TILE = preload("res://scenes/hex.tscn")

var moisture = FastNoiseLite.new()
var village = FastNoiseLite.new()
var altitude = FastNoiseLite.new()

var tile_index = 0

var basepos
var guypos

@export_range(10,100) var grid_size:int = 10
@export_range(0.05,0.2) var noise_roughness = 0.08

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

func _ready() -> void:
	moisture.seed = randi()
	village.seed = randi()
	altitude.seed = randi()
	
	
	moisture.frequency = noise_roughness
	village.frequency = noise_roughness
	altitude.frequency = noise_roughness
	
	
	_generate_grid()
	print("done")

func _generate_grid():
	
	var base = randi_range(0,grid_size*grid_size)
	for x in range(grid_size):
		var tile_coords := Vector2.ZERO
		tile_coords.x = x * TILE_SIZE * cos(deg_to_rad(30))
		tile_coords.y = 0 if x % 2 == 0 else TILE_SIZE / 2
		for y in range(grid_size):
			var tile = HEX_TILE.instantiate()
			tile.moisture = moisture.get_noise_2d(x,y)
			tile.village = village.get_noise_2d(x,y)
			tile.altitude = altitude.get_noise_2d(x,y)
			

			tile.index = tile_index
			tile_index += 1
			tile.translate(Vector3(tile_coords.x, 0, tile_coords.y))
			#GameManager.tile_array.append(tile.position)
			GameManager.tile_array.append(tile)
			GameManager.visited_array.append(false)
			tile_coords.y += TILE_SIZE
			tile.base_index = base
			add_child(tile)
			
			if tile.base == true:
				basepos = tile.global_position
			else:
				pass
