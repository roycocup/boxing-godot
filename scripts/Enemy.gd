extends "res://scripts/Character.gd"

var frame = 0
onready var AI = preload("res://scripts/AI.gd").new()

func _ready():
	AI._ready()


func _physics_process(delta):
	frame_count()
	if (cur_status == status.IDLE):
		animate()
	if (frame % 30 == 1):
		left_punch()

func frame_count():
	frame = frame + 1
	if (frame >= 60):
		frame = 0

func left_punch():
	$Player.play("Left")

func right_punch():
	$Player.play("Right")
	
func _on_face_hit(area_id, area, area_shape, self_shape):
	.move_back(2500)
	$Player.play("Hit")
	world.update_score(2)
