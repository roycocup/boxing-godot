extends KinematicBody2D

export var velocity = 1
var pos
var hit = false
var canvas = null
onready var FSM = preload("res://scripts/FSM.gd").new()
onready var world = get_tree().get_root().get_node("World")
onready var ScoreMan = world.score
onready var score = world.score.get_score_map()
var player_data = {}
var frame = 0


func _ready():
	pos = Vector2()
	FSM.current_state = FSM.states.IDLE
	$Player.connect("animation_finished", self, "change_status")
	init_states()
	
func init_states():
	FSM.add_state(
		FSM.states.IDLE, [
			{"event":FSM.events.LEFT, "to_state":FSM.states.LEFT}, 
			{"event":FSM.events.RIGHT, "to_state":FSM.states.RIGHT}, 
		])
	FSM.add_state(
		FSM.states.LEFT, [
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.RIGHT, [
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.HIT, [
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.PAUSE, [])
	
	FSM.current_state = FSM.states.IDLE

func _physics_process(delta):
	if (FSM.current_state == FSM.states.IDLE):
		movement()
		shots()
		animate()

func shots():
	pass

func movement():
	pass

func kick_back(amount):
	move_and_slide(Vector2(amount,0))
		
func animate():
	match FSM.current_state:
		FSM.states.HIT:
			$Player.play("Hit")
		FSM.states.LEFT:
			$Player.play("Left")
		FSM.states.RIGHT:
			$Player.play("Right")
		FSM.states.IDLE:
			if not $Player.is_playing():
				$Player.play("Idle")
		FSM.states.PAUSE:
			if not $Player.is_playing():
				$Player.play("Idle")
		
func change_status(finished_animation):
	if (FSM.current_state != FSM.states.IDLE):
		reset_status()
		
func reset_status():
	FSM.current_state = FSM.states.IDLE

func frame_count():
	frame = frame + 1
	if (frame >= 60):
		frame = 0

func random_option(options):
	var num_options = count(options)
	randomize()
	var sel = (randi() % num_options) + 1
	return options[sel]

func set_state(event):
	FSM.handle(event)

func get_state():
	return FSM.current_state