extends "res://scripts/Character.gd"

var pname = 'p2'

func _ready():
	player_data['name'] = pname

func _physics_process(_delta):
	# only move or throw punches if you are idle and not doing any other thing
	if (FSM.current_state == FSM.states.IDLE):
		movement()
		shots()
		animate()
	if (FSM.current_state == FSM.states.PAUSE):
		animate()
		

func shots():
	if .is_cool():
		.reset_cooldown()
		var opponent_pos = world.Players['p1'].position
		var dist = opponent_pos - position
		# var direction = dist.normalized()
		if (abs(dist.x) < 120):
			if (dist.y < 0):
				.set_state(FSM.events.LEFT)
			elif (dist.y > 1):
				.set_state(FSM.events.RIGHT)
			else:
				.random_option([.set_state(FSM.events.LEFT), .set_state(FSM.events.RIGHT)])
		

func movement():
	if (is_winning()):
		chase()
	elif (!is_winning()):
		if (score_diff() > 6):
			chase()
		else:
			evade()
	else:
		chase()
	
func score_diff():
	return score['p1'] - score['p2']
	
func is_winning():
	return score['p1'] < score['p2']
	
func chase():
	var opponent_pos = world.Players['p1'].position
	var dist = opponent_pos - position
	var direction = dist.normalized()
	move_and_slide(direction * velocity, Vector2())

func evade():
	var opponent_pos = world.Players['p1'].position
	var dist = opponent_pos - position
	var direction = dist.normalized()
	return move_and_slide(-direction * velocity, Vector2())

func left_punch():
	$Player.play("Left")

func right_punch():
	$Player.play("Right")
	
func _on_face_hit(_area_id, area, _area_shape, _self_shape):
	.take_hit_on_health(area)
	.kick_back(kickback_amount)
	$Player.play("Hit")
	if world.sound_on: 
		$Punch.play()
	scoreMananager.update(player_data)
