extends Node3D

## The Time It Takes For The Sun To Make 1 Full Rotation In Minutes
@export var daynight_time:float = 600
@onready var sub_viewport: SubViewport = $".."
@onready var GATHERER = preload("res://actors/player/Gatherer.tscn")
@onready var SCOUT = preload("res://actors/player/scout.tscn")
@onready var INVADER = preload("res://actors/player/invader.tscn")
@onready var BUILDER = preload("uid://bub3igdo8fe7q")
@onready var actor : PackedScene = BUILDER
var button_hover = false
var start_tile = null
var end_tile = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var daylight_cycle = create_tween()
	#daylight_cycle.tween_property($DirectionalLight3D,"rotation_degrees",Vector3(205,25,17),daynight_time * 60).from(Vector3(-155,25,17))
	#daylight_cycle.set_loops()
	#var moonlight_cycle = create_tween()
	#moonlight_cycle.tween_property($DirectionalLight3D2,"rotation_degrees",Vector3(335,-15,-18),daynight_time * 80).from(Vector3(-25,-15,-18))
	#moonlight_cycle.set_loops()
	sub_viewport.size = get_viewport().size
	GameManager.current_camera = $Node3D/Camera3D
	GameManager.camera = $Node3D/Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MeshInstance3D.rotation += Vector3(0,0.0001,0)
	$MeshInstance3D.global_position.x = GameManager.base_pos.x
	$MeshInstance3D.global_position.z = GameManager.base_pos.z
	var ocean_material = load("res://world/main.tscn::StandardMaterial3D_a8y0u")
		
	if Input.is_action_just_pressed("mouse_left"):
		if button_hover == false:
			var raycast_result = fire_clickable_raycast()
			if raycast_result and raycast_result.has("collider"):
				#Pick Start Tile
				var clicked_tile = raycast_result.collider.get_parent()
				if clicked_tile.evil != null:
					if clicked_tile != start_tile and start_tile != null:
						start_tile.start = false
					start_tile = clicked_tile
					start_tile.start = true
					
	if Input.is_action_just_pressed("mouse_right"):
		if button_hover == false:
			var raycast_result = fire_clickable_raycast()
			if raycast_result and raycast_result.has("collider"):
				#Pick End Tile
				var clicked_tile = raycast_result.collider.get_parent()
				print(clicked_tile.index)
				end_tile = clicked_tile
				end_tile.end = true
				#if start_tile and end_tile:
				var actor_instance = actor.instantiate()
				actor_instance.setup(start_tile.index, end_tile.index)
				add_child(actor_instance)
		
	if Input.is_action_just_pressed("step"):
		SignalBus.emit_signal("new_turn")

func _on_check_button_pressed() -> void:
	pass # Replace with function body.

	
	#if ray_result != {}:
	#clickable_raycast.emit(ray_result)

func fire_clickable_raycast() -> Dictionary:
	var _cam = GameManager.current_camera
	var RAYCAST_LENGTH = 1000
	var space_state = $"..".get_parent().get_viewport().get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var origin = _cam.project_ray_origin(mouse_pos)
	var direction = _cam.project_ray_normal(mouse_pos)
	var end = origin + direction * RAYCAST_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, 4 )
	query.collide_with_areas = true

	var ray_result = space_state.intersect_ray(query)
	return ray_result






func _on_button_2_pressed() -> void:
	actor = SCOUT
	


func _on_button_3_pressed() -> void:
	actor = GATHERER


func _on_button_4_pressed() -> void:
	actor = INVADER


func _on_button_pressed() -> void:
	$Node3D.global_position = GameManager.base_pos
	
