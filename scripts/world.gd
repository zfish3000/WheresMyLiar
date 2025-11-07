extends Node3D

## The Time It Takes For The Sun To Make 1 Full Rotation In Minutes
@export var daynight_time:float = 600
@onready var sub_viewport: SubViewport = $".."
@onready var ACTOR = preload("res://scout.tscn")
var button_hover = false
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
	pass
		
		
	if Input.is_action_just_pressed("mouse_left"):
		if button_hover == false:
			var raycast_result = fire_clickable_raycast()
			if raycast_result and raycast_result.has("collider"):
				var clicked_tile = raycast_result.collider.get_parent()
				print(clicked_tile.index)
				var actor = ACTOR.instantiate()
				actor.setup(GameManager.base_id, clicked_tile.index)
				add_child(actor)

			else:
				print("nothing right there :0")


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




func _on_button_bounding_box_mouse_entered() -> void:
	button_hover = true
	print('hello')


func _on_button_bounding_box_mouse_exited() -> void:
	button_hover = false
	print('goodbye')
