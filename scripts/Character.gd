extends KinematicBody2D

export var velocity = 1
var pos
enum status {IDLE, RIGHT, LEFT, HIT}
var cur_status
var hit = false
var canvas = null
onready var FSM = preload("res://scripts/FSM.gd").new()
onready var world = get_tree().get_root().get_node("World")
var player_data = {}


func get_random_num():
	randomize()
	return randf()

func randomize_character_colour():
	var r = get_random_num()
	var g = get_random_num()
	var b = get_random_num()
	var c = Color(r,g,b)
	$Sprite.self_modulate = c

func _ready():
	randomize_character_colour()
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

func move_back(amount):
	move_and_slide(Vector2(amount,0))
		
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

