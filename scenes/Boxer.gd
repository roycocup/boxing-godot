extends KinematicBody2D

export var speed = 1

enum status {IDLE, RIGHT, LEFT, HIT}
var cur_status

func _ready():
	cur_status = status.IDLE
	$Player.connect("animation_finished", self, "change_status")

func _process(delta):
	if (cur_status == status.IDLE):
		listen_to_keys()
		animate()


func listen_to_keys():
	if Input.is_key_pressed(KEY_Z):
		cur_status = status.LEFT
		
	if Input.is_key_pressed(KEY_X):
		cur_status = status.RIGHT
		
	if Input.is_key_pressed(KEY_0):
		cur_status = status.HIT

func animate():
	match cur_status:
		status.HIT:
			$Player.play("Hit")
		status.LEFT:
			$Player.play("Left")
		status.RIGHT:
			$Player.play("Right")
		status.IDLE:
			$Player.play("Idle")
		
func change_status(finished_animation):
	if (cur_status != status.IDLE):
		reset_status()
		
func reset_status():
	cur_status = status.IDLE

