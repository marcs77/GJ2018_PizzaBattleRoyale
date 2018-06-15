extends Node

func _ready():
	
	pass

func restart():
	get_tree().change_scene("res://Restart.tscn")
	
func _process(delta):
	if ($Player.is_dead()):
		restart()
		
	
