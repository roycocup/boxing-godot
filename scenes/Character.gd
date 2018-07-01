extends KinematicBody2D

export var velocity = 1
var pos
enum status {IDLE, RIGHT, LEFT, HIT}
var cur_status
var hit = false

func _ready():
	pos = Vector2()
	cur_status = status.IDLE
	$Player.connect("animation_finished", self, "change_status")

func _physics_process(delta):
	if (cur_status == status.IDLE):
		movement()
		shots()
		animate()

func shots():
	pass

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

