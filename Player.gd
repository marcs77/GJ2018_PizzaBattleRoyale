extends KinematicBody2D

export (PackedScene) var FOOD_ITEM

export (float) var GRAVITY_DOWN = 800
#export (float) var GRAVITY_UP = 800

export (float) var JUMP_TIME = 0.5
export (float) var JUMP_SPEED = 250
export (float) var MAX_WALK_SPEED = 200
export (int) var MAX_HEALTH = 100
export (float) var THROW_SPEED = 800
export (float) var SHOOT_COOLDOWN = 1
export (float) var Po = 1

var activated = true
var vel = Vector2()
var jumping = false
var jumpingTime = 0
var points = 10
var health

var shootTimer = 0

func addPoints(additionalPoints):
	points+=additionalPoints

func _ready():
	$AnimatedSprite.play()
	health = MAX_HEALTH
	pass

func reduceHealth (healthToReduce):
	health = clamp (health -healthToReduce,0,MAX_HEALTH)
	$Die.play()

func dieSOUND():
	$Die.play()

func kill ():
	health = 0
	
func _process(delta):
	pass

func is_dead():
	return health == 0
	
func get_input(delta):
	var hInput = 0
	vel.x = 0
	
	if Input.is_action_pressed("player_left"):
		hInput -= 1
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("player_right"):
		hInput += 1
		$AnimatedSprite.flip_h = false
	
	if Input.is_action_pressed("player_up") and is_on_floor():
		jumping = true
		jumpingTime = 0
	elif !Input.is_action_pressed("player_up"):
		jumping = false
		
	if Input.is_action_just_pressed("fire") and shootTimer > SHOOT_COOLDOWN and points > 0:
		var p = FOOD_ITEM.instance()
		print("sdfsdfasdf")
		get_tree().root.add_child(p)
		p.position = position
		p.set_linear_velocity(get_local_mouse_position().normalized() * THROW_SPEED)
		add_collision_exception_with(p)
		points-=1
		shootTimer = 0
	else:
		shootTimer += delta
	vel.x = hInput * MAX_WALK_SPEED
	
		
	
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
	
func _physics_process(delta):
	if !activated:
		return
	get_input(delta)
	
	if is_on_floor():
		vel.y = 0
	
	if jumping:
		jumpingTime += delta
		vel.y = -JUMP_SPEED
	else:
		vel.y += GRAVITY_DOWN * delta
	
	if jumpingTime > JUMP_TIME:
		jumping = false
	
	vel = move_and_slide(vel, Vector2(0, -1))