extends Control

const MOUSE = preload("uid://i1li7i8liyit")
const Label1 = preload("res://label1.tres")
const Label2 = preload("res://label2.tres")
const Label3 = preload("res://label3.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite2D.position = lerp($Sprite2D.position, get_global_mouse_position(), 0.5)
	var bgmaterial = load("res://scenes/menu.tscn::ShaderMaterial_i6lef")
	


func _on_button_pressed() -> void:
	$AnimationPlayer.play("startgame")
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer/VBoxContainer/Button/Label, "visible_characters", 0, 1)
	SfxManager.pitchsfx(SfxManager.select)
	
func new_game():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_button_3_pressed() -> void:
	get_tree().quit()


func _on_button_mouse_entered() -> void:
	var button1_shader = load("res://scenes/menu.tscn::ShaderMaterial_70i5f")
	button1_shader
	button1_shader.set_shader_parameter('intensityX',3.0)
	button1_shader.set_shader_parameter('intensityY',3.0)


func _on_button_mouse_exited() -> void:
	var button1_shader = load("res://scenes/menu.tscn::ShaderMaterial_70i5f")
	button1_shader
	button1_shader.set_shader_parameter('intensityX',0.0)
	button1_shader.set_shader_parameter('intensityY',0.0)
