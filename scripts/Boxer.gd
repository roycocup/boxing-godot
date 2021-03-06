extends "res://scripts/Character.gd"

func _ready():
	player_data['name'] = 'p1'
	._ready() # calling parent setup

func _physics_process(_delta):
	# only process these if we are idle
	# if we are not idle, let the animations run and end
	if (FSM.assert_state(FSM.states.IDLE)):
		movement()
		shots()
		animate()
	if (FSM.assert_state(FSM.states.PAUSE)):
		animate()
	
func shots():
	if Input.is_action_just_pressed("fire_1"):
		.set_state(FSM.events.LEFT)
	if Input.is_action_just_pressed("fire_2"):
		.set_state(FSM.events.RIGHT)
	if Input.is_key_pressed(KEY_0):
		.set_state(FSM.events.HIT)

func movement():
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(velocity, 0), Vector2())
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-velocity, 0), Vector2())
	if Input.is_action_pressed("ui_up"):
		move_and_slide(Vector2(0, -velocity), Vector2())
	if Input.is_action_pressed("ui_down"):
		move_and_slide(Vector2(0, velocity), Vector2())
		
func _on_face_hit(_area_id, area, _area_shape, _self_shape):
	.take_hit_on_health(area)
	.set_state(FSM.events.HIT)
	.kick_back(-2500)
	$Player.play("Hit")
	if world.sound_on: 
		$Punch.play()
	scoreMananager.update(player_data)
