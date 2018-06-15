extends Panel


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



func _on_Restart_pressed():
	get_tree().change_scene("res://MundoPizza.tscn")
