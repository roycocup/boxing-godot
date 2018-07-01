extends "res://scenes/Character.gd"



func _physics_process(delta):
	if (cur_status == status.IDLE):
		movement()
		animate()

func movement():
	pass
	


