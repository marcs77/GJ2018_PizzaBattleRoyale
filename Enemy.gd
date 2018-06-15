extends KinematicBody2D

enum { STATE_WALKING, STATE_IDLE }

export (PackedScene) var FOOD_ITEM

export (float) var WALK_SPEED = 200
export (int) var MAX_HEALTH = 100
export (float) var THROW_SPEED = 400
export (float) var MAX_ABYSS = 250
export (float) var GRAVITY = 800
export (float) var RADIUS = 800

var vel = Vector2()

var idle = false
var jumping = false
var walk_left = false
var action_timer = 0
var shootTime = 0
var nextShoot = 2

var health = MAX_HEALTH

var player

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
	player = get_parent().find_node("Player")

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
	
	if position.distance_to(player.position) < RADIUS:
		if shootTime > nextShoot:
			var dir = (player.position - position).normalized()
			var p = FOOD_ITEM.instance()
			get_tree().root.add_child(p)
			p.position = position
			p.isEvil = true
			p.setEvil()
			p.set_linear_velocity(dir * THROW_SPEED)
			add_collision_exception_with(p)
			shootTime = 0
		else:
			shootTime += delta
	vel = move_and_slide(vel, Vector2(0,-1))
	
	if jumping:
		$AnimatedSprite.animation = "jump"
	else:
		
		if vel.x != 0:
			if !(is_on_floor() || is_on_wall()):
				$AnimatedSprite.animation = "jump"
			else:
				$AnimatedSprite.animation ="run"		
		else:
			$AnimatedSprite.animation = "stand"
	if vel.x > 0:
		$AnimatedSprite.flip_h = false
	elif vel.x < 0:
		$AnimatedSprite.flip_h = true


func _on_AttackArea_body_entered(body):
	if body is preload("res://Player.gd"):
		body.kill()
