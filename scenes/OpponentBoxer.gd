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
		movement()
		animate()



func shots():
	if Input.is_action_just_pressed("fire_1"):
		cur_status = status.LEFT
	if Input.is_action_just_pressed("fire_2"):
		cur_status = status.RIGHT		
	if Input.is_key_pressed(KEY_0):
		cur_status = status.HIT

func movement():
	pass
	
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
		
func change_status(finished_animation):
	if (cur_status != status.IDLE):
		reset_status()
		
func reset_status():
	cur_status = status.IDLE

