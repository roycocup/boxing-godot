extends "res://scenes/Character.gd"

func _physics_process(delta):
	if (cur_status == status.IDLE):
		animate()
	

func _on_Hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	var back = -1
	if rotation > 0:
		back = 1 
	position.x = position.x + (5 * back) 
	$Player.play("Hit")