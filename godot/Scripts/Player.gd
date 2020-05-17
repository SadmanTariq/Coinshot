extends KinematicBody2D

export var mass = 70
export var gravity_constant = 20
export var jump_speed = 600
export var move_force = 5000
export var drag = 10
export var coin_throw_force = 500
export var steelpush_strength = 2000
export var steelpush_flare_strength = 4000

export (PackedScene) var coin = preload("res://Scenes/Coin.tscn")

var resultant_force = Vector2()
var acceleration = Vector2()
var velocity = Vector2()
var weight

var facing_right = true

var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	weight = Vector2(0, mass * gravity_constant)


func _process(delta):
	if dead and Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()


#func _input(event):
#	if event.is_action_pressed("throw_coin"):
#		throw_coin()


func _physics_process(delta):
	resultant_force = Vector2()
	var grounded = is_on_floor()
	
	
	var move_vector_x = 0
	if Input.is_action_pressed("move_right"):
		move_vector_x += 1
	if Input.is_action_pressed("move_left"):
		move_vector_x -= 1
	if Input.is_action_pressed("jump") and grounded:
		jump()
	if Input.is_action_pressed("steel_push"):
		if Input.is_action_pressed("flare"):
			steel_push_selected(true)
		else:
			steel_push_selected()
	if Input.is_action_just_pressed("throw_coin"):
		throw_coin()
	
	resultant_force += Vector2(move_vector_x * move_force, 0)
#	if !grounded:
	resultant_force += weight
	resultant_force -= Vector2(velocity.x * drag, 0)
	
	acceleration = resultant_force / mass
	velocity += acceleration
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if move_vector_x > 0.0 and !facing_right:
		flip()
	elif move_vector_x < 0.0 and facing_right:
		flip()


func jump():
	if dead:
		return
	velocity.y = -jump_speed


func flip():
	$Sprite.flip_h = !$Sprite.flip_h
	facing_right = !facing_right


func throw_coin():
	print("thrown at", (get_global_mouse_position() - position).angle())
	var coin_instance = coin.instance()
	owner.add_child(coin_instance)
	coin_instance.position = position
	coin_instance.linear_velocity.x = velocity.x
	var impulse = (get_global_mouse_position() - position).normalized()
	impulse *= coin_throw_force
	coin_instance.apply_central_impulse(impulse)


func steel_push_selected(flared=false):
	var target = get_tree().get_nodes_in_group("selected")[0]
	var strength = steelpush_strength
	if flared:
		strength = steelpush_flare_strength
	var push_origin = target.apply_push(global_position, strength, mass)
	
	if push_origin != null:
		self_push(push_origin, strength)


func self_push(push_origin: Vector2, strength):
	resultant_force += (global_position - push_origin).normalized() * strength
