extends KinematicBody2D

export (float) var GRAVITY_DOWN = 800
#export (float) var GRAVITY_UP = 800

export (float) var JUMP_TIME = 0.5
export (float) var JUMP_SPEED = 250
export (float) var MAX_WALK_SPEED = 200

var vel = Vector2()
var jumping = false
var jumpingTime = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_input():
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
		
	vel.x = hInput * MAX_WALK_SPEED
func _physics_process(delta):
	get_input()
	
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