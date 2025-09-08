extends Node3D

@export var size : float
@export var time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector3(size,size,size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
