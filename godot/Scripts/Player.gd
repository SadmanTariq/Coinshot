extends KinematicBody2D

export var move_speed = 200
export var gravity = 20
export var jump_force = 400

var velocity = Vector2()
var drag = 0.5

var facing_right = true

var dead = false

var coin = preload("res://Scenes/Coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if dead and Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	var move_vector = Vector2()
	if !dead:
		if Input.is_action_pressed("move_left"):
			move_vector.x -= 1
		if Input.is_action_pressed("move_right"):
			move_vector.x += 1
	
	velocity += move_vector * move_speed - drag * Vector2(velocity.x, 0)
	
	var cur_grounded = is_on_floor()
	
	var pressed_jump = Input.is_action_just_pressed("jump")
	
	if (pressed_jump and cur_grounded):
		jump()
	
	velocity.y += gravity
	
	if cur_grounded and velocity.y > 10:
		velocity.y = 10
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if move_vector.x > 0.0 and !facing_right:
		flip()
	elif move_vector.x < 0.0 and facing_right:
		flip()


func jump():
	if dead:
		return
	velocity.y = -jump_force


func flip():
	$Sprite.flip_h = !$Sprite.flip_h
	facing_right = !facing_right
