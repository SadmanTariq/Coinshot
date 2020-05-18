extends Node2D

export var max_coins = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var coins = get_tree().get_nodes_in_group("coin")
	if len(coins) > max_coins:
		coins[0].queue_free()
