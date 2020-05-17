extends RigidBody2D

export var push_multiplier = .0001


func _ready():
	contact_monitor = true
	contacts_reported = 3


func apply_push(origin: Vector2, strength: float, pusher_mass: float):
	var magnitude = strength * push_multiplier
	var push_vector = (global_position - origin).normalized() * magnitude
	if mass > pusher_mass:
		return global_position
	
	apply_central_impulse(push_vector)
	
	if len(get_colliding_bodies()) > 0:
		return global_position
	else:
		return null
	
