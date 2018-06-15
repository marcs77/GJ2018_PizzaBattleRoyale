extends Node

var once = false

func _ready():
	
	pass

func restart():
	get_tree().change_scene("res://Restart.tscn")
	
func _process(delta):
	if ($Player.is_dead()) and !once:
		once = true
		$Player.activated = false
		$Player.get_node ("AnimatedSprite").animation ="killed"
		$Music.stop()
		
		
		var t = Timer.new()
		t.set_wait_time(2)
		add_child(t)
		t.start()
		$Player.dieSOUND()
		yield(t, "timeout") 
		restart()
		
	
