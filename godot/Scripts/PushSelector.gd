extends Node2D

export var selectable_group = "selectable"
export var selected_group = "selected"

var allo_lines_manager

func _ready():
	pass


# Called when the node enters the scene tree for the first time.
#func _ready():
#	allo_lines_manager = $"../AlloLinesManager"
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	var selectable_objects = []
#	for l in allo_lines_manager.get_children():
#		selectable_objects.append(l.attached_object)
#
#	if len(selectable_objects) > 1:
#		print(selectable_objects)
#
#	if len(selectable_objects) == 0:
#		return
#
#	var angles = []
#
#	var mouse_pos = get_global_mouse_position()
#	for object in selectable_objects:
#		angles.append(abs(mouse_pos.angle_to(object.global_position)))
#
#	var selected_index = 0
#	for i in range(len(angles)):
#		if angles[i] < angles[selected_index]:
#			selected_index = i
#
#	for i in range(len(selectable_objects)):
#		if i == selected_index:
#			selectable_objects[i].add_to_group(selected_group)
#		else:
#			selectable_objects[i].remove_from_group(selectable_group)


func _process(_delta):
	var selectable_objects = get_tree().get_nodes_in_group(selectable_group)

	if len(selectable_objects) == 0:
		return

	var angles = []

	var mouse_pos = get_global_mouse_position()
	for object in selectable_objects:
		angles.append(abs(mouse_pos.angle_to(object.global_position)))

	var selected_index = 0
	for i in range(len(angles)):
		if angles[i] < angles[selected_index]:
			selected_index = i

	for i in range(len(selectable_objects)):
		if i == selected_index:
			selectable_objects[i].add_to_group(selected_group)
		else:
			selectable_objects[i].remove_from_group(selected_group)
