extends TouchScreenButton

# Gonkee's joystick script for Godot 3 - full tutorial https://youtu.be/uGyEP2LUFPg
# If you use this script, I would prefer if you gave credit to me and my channel

# Change these based on the size of your button and outer sprite
var radius = Vector2(32, 32)
var boundary = 64
var ongoing_drag = -1
var return_accel = 20
var threshold = 0


func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2(-32, -32) - radius) - position
		position += pos_difference * return_accel * delta

func get_button_pos():
	return position + radius

func _input(event):
	if Input.is_action_pressed("exit"):
		get_tree().quit()

	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var parent_pos = get_parent().global_position
		var event_dist_from_centre = (event.position - parent_pos).length()
	
		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position((event.position-Vector2(32, 32)) - radius * global_scale)

			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius)

			ongoing_drag = event.get_index()

	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1

