extends "res://scenes/Character.gd"

func _physics_process(delta):
	if (cur_status == status.IDLE):
		animate()
	

func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(2500)
	$Player.play("Hit")
