extends "res://scenes/Character.gd"

var frame = 0


func _physics_process(delta):
	frame_count()
	if (cur_status == status.IDLE):
		animate()
	if (frame % 30 == 1):
		$Player.play("Left")

func frame_count():
	frame = frame + 1
	if (frame >= 60):
		frame = 0
	

func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(2500)
	$Player.play("Hit")
