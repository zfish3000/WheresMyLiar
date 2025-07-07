extends Node
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			var tween = get_tree().create_tween()
			tween.tween_property(Engine,"time_scale",0,0.2)
			tween.set_ease(Tween.EASE_OUT)
			tween.set_trans(Tween.TRANS_CUBIC)
			paused = true
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(Engine,"time_scale",1,0.2)
			tween.set_ease(Tween.EASE_OUT_IN)
			tween.set_trans(Tween.TRANS_CUBIC)
			paused = false
	
	$Sprite2D.position = lerp($Sprite2D.position, $CanvasLayer/ColorRect.get_global_mouse_position(), 0.5)
		
