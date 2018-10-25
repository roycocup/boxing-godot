extends "res://scenes/Character.gd"

func _physics_process(delta):
	if (cur_status == status.IDLE):
		animate()
	

func hit(area_id, area, area_shape, self_shape):
	pass	


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print('body')
	pass # replace with function body


func move_back(amountpx):
	if rotation > 0:
		amountpx = amountpx * 1 # invert signal
	position.x = position.x + amountpx 

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	move_back(25)
	$Player.play("Hit")
