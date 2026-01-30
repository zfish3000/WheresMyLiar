extends Node3D

var hex_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.new_turn.connect(new_turn)
	

func new_turn():
	return
	var rng = randf()
	if rng <= 0.05:
		if GameManager.hero_count < 10:
			spawn_hero()
			GameManager.hero_count += 1
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rng = randi_range(1,2)
	if rng == randi_range(1,2):
		#spawn_hero()
		pass

func spawn_hero():
	var hero_scene : PackedScene = load("res://actors/enemy/hero.tscn")
	var hero = hero_scene.instantiate()
	hero.setup(hex_index,GameManager.base_id)
	hero.position = position
	add_child(hero)
