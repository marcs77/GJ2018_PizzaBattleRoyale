extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_death():
	queue_free()

func _on_Projectile_body_entered(body):
	if body is preload("res://Enemy.gd"):
		body.kill()
	