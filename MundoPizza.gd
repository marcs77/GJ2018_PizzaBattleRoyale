extends Node

func _ready():
	
	pass

func restart():
	get_tree().change_scene("res://Restart.tscn")
	
func _process(delta):
	if ($Player.is_dead()):
		$Player.activated = false
		$Player.get_node ("AnimatedSprite").animation ="killed"
		var t = Timer.new()
		t.set_wait_time(2)
		add_child(t)
		t.start()
		yield(t, "timeout") 
		restart()
		
	
