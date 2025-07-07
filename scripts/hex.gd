extends Node3D
class_name Hex

var score

var moisture
var village
var altitude

var land
var hot
var high

var smog_particles = preload("res://scenes/smog.tscn")
var find_node = preload("res://scenes/finder.tscn")

var mouse = false

var index
var base_index
var base = false

var type
var walkable = true
var found = false

var g
var h
var f

func set_label(score:String):
	pass
	

@export var meshes:Array[Resource]
#array value meaning
#0=plains
#1=forest
#2=ocean
#3=beach
#4=mountains

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	SignalBus.base_defined.connect(_base_defined)
	
	if index == base_index:
		base=true
		GameManager.base_id = index
		GameManager.base_pos = position
		SignalBus.base_defined.emit()
	else:
		base=false
	#randommeshes
	#var meshrng = randi_range(0,(meshes.size()-1))
	#$MeshInstance3D.mesh = meshes[meshrng]
	var rotaterng = randi_range(0,3)
	
	#old procedural uising mositure
	#if moisture>=0.2:
		#$MeshInstance3D.mesh = meshes[1]
	#if moisture>=0.01 and moisture <0.2:
		#$MeshInstance3D.mesh = meshes[0]
	#if moisture<0.01:
		#$MeshInstance3D.mesh = meshes[2]
	if base == false:
		if moisture>=0.1:
			land = true
		if moisture<0.01:
			land = false
			walkable = false
		if altitude>=0.4:
			type = 4
			walkable = false
		if altitude>=0.2 and altitude <0.4:
			type=2
		if altitude<0.2:
			if village <0.5:
				var bush = randi_range(0,3)
				if bush < 3:
					type=0
				if bush == 3:
					type=1
			else:
				type=6
		if land == false:
			type = 3
	elif base == true:
		type = 5
		var smog = smog_particles.instantiate()
		smog.position.y = 1.851
		smog.position.y += altitude
		add_child(smog)
		var finder = find_node.instantiate()
		finder.position.y = 0
		add_child(finder)
		

	position.y += altitude
	position.y = round(position.y+0.2)
	position.y = clamp(position.y,0,0.17)
	round(position.y)

	
	match rotaterng:
		0:
			$MeshInstance3D.rotation_degrees += Vector3(0,60,0)
		1:
			$MeshInstance3D.rotation_degrees += Vector3(0,120,0)
		2:
			$MeshInstance3D.rotation_degrees += Vector3(0,180,0)
		3:
			$MeshInstance3D.rotation_degrees += Vector3(0,0,0)
			
			
	GameManager.walk_array.append(walkable)
	
	if GameManager.base_pos != Vector3(0,0,0):
		score = abs(position.x - GameManager.base_pos.x) + abs(position.z - GameManager.base_pos.z)
		set_label(str(round(score)))
		GameManager.score_array.append(score)
	
	$Label3D.text=str(index)


func _process(delta: float) -> void:
	

	if found:
		match type:
			0:
				$MeshInstance3D.mesh = meshes[0]
			1:
				$MeshInstance3D.mesh = meshes[1]
			2:
				$MeshInstance3D.mesh = meshes[2]
			3:
				$MeshInstance3D.mesh = meshes[3]
			4:
				$MeshInstance3D.mesh = meshes[4]
			5:
				$MeshInstance3D.mesh = meshes[5]
			6:
				$MeshInstance3D.mesh = meshes[6]
	else:
		if base:
			return
		else:
			$MeshInstance3D.mesh = meshes[7]
		
func _on_area_3d_area_entered(area: Area3D) -> void:
	found = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	found = true

func _base_defined():
	score = abs(position.x - GameManager.base_pos.x) + abs(position.z - GameManager.base_pos.z)
	set_label(str(round(score)))
	GameManager.score_array.append(score)


func _on_area_3d_mouse_entered() -> void:
	scale = Vector3(0.7,0.7,0.7)
