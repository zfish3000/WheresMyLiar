extends Node
class_name BuildingMaterial

var wood
var stone
var money
var pop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func set_resource(hex_type:int):
	match hex_type:
		0 or 1:
			wood = randi_range(0,1)
			stone = randi_range(0,1)
			money = 1
			pop = randi_range(1,2)
		2:
			wood = randi_range(4,5)
			stone = randi_range(1,3)
			money = 0 
			pop = 0
		3:
			wood = 0
			stone = 0
			money = 0
			pop = 0
		4:
			wood = randi_range(1,2)
			stone = randi_range(4,5)
			money = randi_range(0,2)
			pop = 0
		5:
			wood = 0
			stone = 0
			money = 0
			pop = 0
		6:
			wood = randi_range(0,1)
			stone = randi_range(0,1)
			money = randi_range(3,4)
			pop = randi_range(6,7)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
