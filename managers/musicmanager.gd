extends Node

@onready var maintheme: AudioStreamPlayer = $maintheme


func changebus(song:AudioStreamPlayer,bus:String):
	song.bus = bus
