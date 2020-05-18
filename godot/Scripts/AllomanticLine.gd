extends Line2D

export (Color) var unselected_color
export (Color) var selected_color

export (int) var unselected_width
export (int) var selected_width

export (String) var selected_group

var attached_object

var selected = false


# Called when the node enters the scene tree for the first time.
func _ready():
	make_unselected()
	set_point_position(1, attached_object.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var in_sel_group = attached_object.is_in_group(selected_group)
	if in_sel_group and !selected:
		make_selected()
	elif !in_sel_group and selected:
		make_unselected()
	
	var end_pos = attached_object.global_position - global_position
	set_point_position(1, end_pos)


func make_selected():
	default_color = selected_color
	width = selected_width
	selected = true


func make_unselected():
	default_color = unselected_color
	width = unselected_width
	selected = false
