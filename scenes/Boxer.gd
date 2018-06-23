extends KinematicBody2D

export var velocity = 1
var pos
enum status {IDLE, RIGHT, LEFT, HIT}
var cur_status

func _ready():
	pos = Vector2()
	cur_status = status.IDLE
	$Player.connect("animation_finished", self, "change_status")

func _physics_process(delta):
	if (cur_status == status.IDLE):
		listen_to_keys()
		animate()


func listen_to_keys():
	movement()
	shots()

func shots():
	if Input.is_key_pressed(KEY_Z):
		cur_status = status.LEFT
	if Input.is_key_pressed(KEY_X):
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
			$Player.play("Idle")
		
func change_status(finished_animation):
	if (cur_status != status.IDLE):
		reset_status()
		
func reset_status():
	cur_status = status.IDLE

