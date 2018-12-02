extends "res://scripts/Character.gd"

onready var AI = preload("res://scripts/AI.gd").new()

func _ready():
	player_data['name'] = 'p2'
	AI._ready(player_data)

func _physics_process(delta):
	frame_count()
	if (FSM.current_state == FSM.states.IDLE):
		animate()
	if (frame % 30 == 1):
		left_punch()

func left_punch():
	$Player.play("Left")

func right_punch():
	$Player.play("Right")
	
func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(2500)
	$Player.play("Hit")
	world.update_score(player_data)
