extends Node3D
class_name Actor
enum ActorType {HERO,SCOUT,GATHERER,SOLDIER,INVADER,BUILDER}
@export var actor : ActorType 
var start_index
var end_index
# Max Stat = 20
var health = 0
var attention = 0
var strength = 0
var distraction = 0
var agility = 0

func setup(start,end):
	global_position = GameManager.tile_array[start].position
	$nav.setup(start,end)
	start_index = start
	end_index = end
	health = randf_range(10,20)
	attention = randf_range(5,10)
	strength = randf_range(10,20)
	agility = randf_range(1,20)
	$Detector/CollisionShape3D.shape.radius = attention
	if actor == ActorType.HERO:
		var highest = max(strength,distraction,agility)

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
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("step"):
		$nav.new_turn()
	
func hello():
	print('Hello')

func _on_nav_reached_destination() -> void:
	GameManager.tile_array[end_index].start = false
	GameManager.tile_array[end_index].end = false
	if actor == ActorType.HERO:
		GameManager.hero_count -= 1
		get_tree().quit()
		queue_free()
	elif actor == ActorType.SCOUT:
		GameManager.tile_array[end_index].reveal(5)
	elif actor == ActorType.GATHERER:
		pass
	elif actor == ActorType.INVADER:
		GameManager.tile_array[end_index].build_lookout(GameManager.Camp.LOOKOUT)

func pleh():
	pass

func _on_area_3d_area_entered(area: Area3D) -> void:
	if actor == ActorType.HERO:
		if area.is_in_group('player'):
				pass
