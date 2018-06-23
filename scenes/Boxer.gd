extends KinematicBody2D

export var speed = 1
enum status {IDLE, RIGHT, LEFT, HIT}
var cur_status


func change_status(finished_animation):
	if (cur_status != status.IDLE):
		cur_status = status.IDLE

func _ready():
	cur_status = status.IDLE
	$Player.connect("animation_finished", self, "change_status")
	pass

func _process(delta):
	if cur_status == status.IDLE:
		$Player.play("Idle")
	
	if Input.is_key_pressed(KEY_Z):
		cur_status = status.LEFT
		$Player.play("Left")

	if Input.is_key_pressed(KEY_X):
		cur_status = status.RIGHT
		$Player.play("Right")		
		
	if Input.is_key_pressed(KEY_0):
		cur_status = status.HIT
		$Player.play("Hit")