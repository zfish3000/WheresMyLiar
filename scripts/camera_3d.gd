class_name FreeLookCamera extends Node3D

# Modifier keys' speed multiplier
const SHIFT_MULTIPLIER = 2.5
const ALT_MULTIPLIER = 1.0 / SHIFT_MULTIPLIER


@export_range(0.0, 1.0) var sensitivity: float = 0.25

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

# Movement state
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _acceleration = 30
var _deceleration = -10
var _vel_multiplier = 4

# Keyboard state
var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

var follow_player = false

func _ready() -> void:
	position = GameManager.base_pos + Vector3(0,0,2.5)
	#position = $"../Hexgrid".basepos + Vector3(2,0,0)
	#position = $"../LilGuy".position + Vector3(2,0,0)

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	
	# Receives mouse button input
	#if event is InputEventMouseButton:
		#match event.button_index:
			#MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)

	# Receives key input
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				_w = event.pressed
			KEY_S:
				_s = event.pressed
			KEY_A:
				_a = event.pressed
			KEY_D:
				_d = event.pressed
			KEY_Q:
				_q = event.pressed
			KEY_E:
				_e = event.pressed
			KEY_SHIFT:
				_shift = event.pressed
			KEY_ALT:
				_alt = event.pressed

# Updates mouselook and movement every frame
func _process(delta):
	_acceleration = 30
	_deceleration = -10
	_update_movement(delta)
	if Input.is_action_pressed("q"):
		rotation_degrees += Vector3(0,1.5,0)
	if Input.is_action_pressed("e"):
		rotation_degrees -= Vector3(0,1.5,0)
	if follow_player == true:
		position = (GameManager.player_pos + Vector3(0,0,2.5))
	else:
		pass

# Updates camera movement
func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3(
		(_d as float) - (_a as float), 
		0 - 0,
		(_s as float) - (_w as float)
	)
	
	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * _acceleration * _vel_multiplier * delta \
		+ _velocity.normalized() * _deceleration * _vel_multiplier * delta
	
	# Compute modifiers' speed multiplier
	var speed_multi = 1
	if _shift: speed_multi *= SHIFT_MULTIPLIER
	if _alt: speed_multi *= ALT_MULTIPLIER
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
	
		translate(_velocity * delta * speed_multi)


func _on_button_pressed() -> void:
	follow_player = false
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	var tween3 = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween2.set_trans(Tween.TRANS_CUBIC)
	tween3.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "position", GameManager.base_pos + Vector3(0,0,2.5), 0.5)
	tween2.tween_property($Camera3D, "fov", 70, 0.15)
	tween2.tween_property($Camera3D, "fov", 60, 0.35)
	tween3.tween_property(self, "rotation", Vector3(0,0,0), 0.5)

func _on_check_button_pressed() -> void:
	if follow_player == false:
		follow_player = true
	elif follow_player == true:
		follow_player = false
