extends Node3D
class_name Actor
enum ActorType {HERO,SCOUT,GATHERER,SOLDIER}
@export var actor : ActorType 
var start_index
var end_index

func setup(start,end):
	$nav.setup(start,end)
	start_index = start
	end_index = end
	

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
	if actor == ActorType.HERO:
		pass
	elif actor == ActorType.SCOUT:
		GameManager.tile_array[end_index].reveal(5)
	elif actor == ActorType.GATHERER:
		pass

func pleh():
	pass
