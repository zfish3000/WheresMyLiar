extends Node

@onready var select: AudioStreamPlayer = $select


func playsfx(sfx:AudioStreamPlayer):
	sfx.play()

func pitchsfx(sfx:AudioStreamPlayer):
	sfx.pitch_scale = randf_range(0.8,1.2)
	sfx.play()
	sfx.pitch_scale = 1.0
	
