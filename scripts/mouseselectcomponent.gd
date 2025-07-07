class_name MouseSelectComponent
extends Node3D

signal clicked
enum MouseOverStates {MOUSEOVER, NOMOUSEOVER}

@export var highlight_material: Material
@export var mesh: MeshInstance3D
@export var ray_collider: StaticBody3D
@export var debug: bool = false

var mouseover_state: MouseOverStates = MouseOverStates.NOMOUSEOVER
var previous_next_pass: Material = null

func _ready() -> void:
	#Raycaster.connect("clickable_raycast", _handle_highlight)
	pass
	
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click") && mouseover_state == MouseOverStates.MOUSEOVER:
		emit_signal("clicked")
		$"..".scale = Vector3(0.5,0.5,0.5)


func _handle_highlight(raycast_result):
	if debug:
		print("raycast_result: ", raycast_result)
		print("raycast result has collider: ", raycast_result.has("collider"))
	if raycast_result and raycast_result.has("collider"): 
		var hovered_object = raycast_result["collider"].get_parent()
		if hovered_object == self:
			if mouseover_state == MouseOverStates.NOMOUSEOVER:
				enable_highlight()
		elif mouseover_state == MouseOverStates.MOUSEOVER:
			disable_highlight()
	elif !raycast_result && mouseover_state == MouseOverStates.MOUSEOVER:
		disable_highlight()

## Loops through all of the surface override materials on this mesh.
## Right now, we are only storing the last material's previous "last next_pass". 
## This will create bugs if a material already has a next_pass. Need to create an 
## array on the fly instead.
func enable_highlight():
	var surface_amt = mesh.get_surface_override_material_count()
	if surface_amt == 0:
		push_warning("Trying to highlight a material with no surface override material. Aborting.")
		return
	
	for i in range(0, surface_amt):
		if mesh.get_surface_override_material(i).next_pass:
			previous_next_pass = mesh.get_surface_override_material(i).next_pass
		mesh.get_surface_override_material(i).next_pass = highlight_material
	mouseover_state = MouseOverStates.MOUSEOVER


func disable_highlight():
	var surface_amt = mesh.get_surface_override_material_count()
	if surface_amt == 0:
		push_warning("Trying to disable highlight on a material with no surface override material. Aborting.")
		return
		
	for i in range(0, surface_amt):
		mesh.get_surface_override_material(i).next_pass = previous_next_pass
	mouseover_state = MouseOverStates.NOMOUSEOVER
