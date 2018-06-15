extends Area2D
var player_class = preload("res://Player.gd")

export(int) var AMOUNT = 1

func _ready():
	var animation = $AnimationPlayer.get_animation("Grow")
	animation.set_loop (true)
	$AnimationPlayer.play("Grow")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Pizza_body_entered(body):
	if body is player_class:
		body.addPoints (AMOUNT)
		queue_free()
	
