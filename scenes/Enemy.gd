extends "res://scenes/Character.gd"

func _physics_process(delta):
	if (cur_status == status.IDLE):
		animate()
	

func move_back(amountpx):
	if rotation > 0:
		amountpx = amountpx * 1 # invert signal
	position.x = position.x + amountpx 

func _on_face_hit(area_id, area, area_shape, self_shape):
	move_back(25)
	$Player.play("Hit")
