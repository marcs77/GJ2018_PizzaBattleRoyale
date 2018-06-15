extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (Texture) var withPineapple
export (Texture) var withoutPineapple

var isEvil = false 

func setEvil():
	if isEvil:
		$Sprite.texture = withoutPineapple
	else:
		$Sprite.texture = withPineapple

func _ready():
	setEvil()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_death():
	queue_free()

func _on_Projectile_body_entered(body):
	if body is preload("res://Enemy.gd"):
		body.reduceHealth (20)
		queue_free()
	
	
	