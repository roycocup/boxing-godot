extends "res://scripts/Character.gd"

onready var AI = preload("res://scripts/AI.gd").new()
var pname = 'p2'
export var speed = 100

func _ready():
	player_data['name'] = pname
	AI._ready(player_data)

func _process(delta):
	frame_count()
	# only move or throw punches if you are idle and not doing any other thing
	if (FSM.current_state == FSM.states.IDLE):
		animate()
		movement()
		shots()

func shots():
	var opponent_pos = world.Players['p1'].position
	var dist = opponent_pos - position
	var direction = dist.normalized()
	if (abs(dist.x) < 0):
		if (dist.y < 0):
			FSM.handle(FSM.events.LEFT)
		elif (dist.y > 1):
			FSM.handle(FSM.events.RIGHT)

func movement():
	if (is_winning()):
		chase()
	elif (!is_winning()):
		evade()
	else:
		chase()
	
func is_winning():
	return world.Score['p1'] < world.Score['p2']
	
func chase():
	var opponent_pos = world.Players['p1'].position
	var dist = opponent_pos - position
	var direction = dist.normalized()
	move_and_slide(direction * speed, Vector2())

func evade():
	var opponent_pos = world.Players['p1'].position
	var dist = opponent_pos - position
	var direction = dist.normalized()
	move_and_slide(-direction * speed, Vector2())

func left_punch():
	$Player.play("Left")

func right_punch():
	$Player.play("Right")
	
func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(2500)
	$Player.play("Hit")
	world.update_score(player_data)
