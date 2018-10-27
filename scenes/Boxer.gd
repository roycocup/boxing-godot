extends "res://scenes/Character.gd"


func _physics_process(delta):
	if (cur_status == status.IDLE):
		movement()
		shots()
		animate()
	
func shots():
	if Input.is_action_just_pressed("fire_1"):
		cur_status = status.LEFT
	if Input.is_action_just_pressed("fire_2"):
		cur_status = status.RIGHT		
	if Input.is_key_pressed(KEY_0):
		cur_status = status.HIT

func movement():
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(velocity, 0), Vector2())
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-velocity, 0), Vector2())
	if Input.is_action_pressed("ui_up"):
		move_and_slide(Vector2(0, -velocity), Vector2())
	if Input.is_action_pressed("ui_down"):
		move_and_slide(Vector2(0, velocity), Vector2())
		
func animate():
	match cur_status:
		status.HIT:
			$Player.play("Hit")
		status.LEFT:
			$Player.play("Left")
		status.RIGHT:
			$Player.play("Right")
		status.IDLE:
			if not $Player.is_playing():
				$Player.play("Idle")
		

func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(-2500)
	cur_status = status.HIT
	$Player.play("Hit")
	cur_status = status.IDLE


