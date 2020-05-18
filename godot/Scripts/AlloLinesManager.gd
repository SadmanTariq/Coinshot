extends Node2D


export var lineable_group = "pushable"
export var selectable_group = "selectable"

var allomantic_line = preload("res://Scenes/AllomanticLine.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func add_line(attached_object):
	var line_instance = allomantic_line.instance()
	line_instance.attached_object = attached_object
	add_child(line_instance)


func _on_AlloLinesCheck_body_entered(body):
	if !body.is_in_group(lineable_group):
		return
	
	body.add_to_group(selectable_group)
	add_line(body)


func _on_AlloLinesCheck_body_exited(body):
	if !body.is_in_group(lineable_group):
		return
	
	body.remove_from_group(selectable_group)
	
	for line in get_children():
		if line.attached_object == body:
			line.queue_free()
