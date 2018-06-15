extends KinematicBody2D

enum { STATE_WALKING, STATE_IDLE }

export (float) var WALK_SPEED = 200
export (int) var MAX_HEALTH = 100
export (float) var THROW_SPEED = 800
export (float) var MAX_ABYSS = 250
export (float) var GRAVITY = 800

var vel = Vector2()

var idle = false
var walk_left = false
var action_timer = 0

var health = MAX_HEALTH

func _process(delta):
	if (health == 0):
		kill()

func kill():
	queue_free()
	
func reduceHealth(dmg):
	health -= dmg
	if health == 0:
		queue_free()

func _ready():
	# Called every time the node is added t the scene.
	# Initialization here
	pass

func _physics_process(delta):
	var hmov = 0
	vel.x = 0
	
	var aleft = false
	var aright = false
	
	aleft = $RayLeft.is_colliding()
	aright = $RayRight.is_colliding()
	
	

		
	if action_timer < 2:
		action_timer += delta
		if !idle:
			if !aright and !walk_left:
				walk_left = true
			if !aleft and walk_left:
				walk_left = false
			
			hmov = -1 if walk_left else 1
			
	else:
		idle = !idle
		action_timer = 0
		walk_left = randi() % 2 == 0
	
	vel.x = WALK_SPEED*hmov
	vel.y += GRAVITY*delta
		
	vel = move_and_slide(vel, Vector2(0,-1))


func _on_AttackArea_body_entered(body):
	if body is preload("res://Player.gd"):
		body.kill()
