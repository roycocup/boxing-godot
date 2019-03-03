extends KinematicBody2D


var pos
var hit = false
var canvas = null
onready var FSM = preload("res://scripts/FSM.gd").new()
onready var world = get_tree().get_root().get_node("World")
onready var ScoreMan = world.score
onready var score = world.score.get_score_map()
var player_data = {}
var frame = 0


# Character basic properties
export var velocity = 1
export var stamina = 100
export var power = 100
var healthpoints = 10000
var hitpoints = 100
signal been_hit


func _ready():
	pos = Vector2()
	FSM.current_state = FSM.states.IDLE
	$Player.connect("animation_finished", self, "change_status")
	init_states()
	
func init_states():
	FSM.add_state(
		FSM.states.IDLE, [
			{"event":FSM.events.PAUSE, "to_state":FSM.states.PAUSE},
			{"event":FSM.events.LEFT, "to_state":FSM.states.LEFT}, 
			{"event":FSM.events.RIGHT, "to_state":FSM.states.RIGHT}, 
		])
	FSM.add_state(
		FSM.states.LEFT, [
			{"event":FSM.events.PAUSE, "to_state":FSM.states.PAUSE},
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.RIGHT, [
			{"event":FSM.events.PAUSE, "to_state":FSM.states.PAUSE},
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.HIT, [
			{"event":FSM.events.PAUSE, "to_state":FSM.states.PAUSE},
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE}, 
		])
	FSM.add_state(
		FSM.states.PAUSE, [
			{"event":FSM.events.IDLE, "to_state":FSM.states.IDLE},
		])
	
	FSM.current_state = FSM.states.IDLE

func _physics_process(delta):
	if (FSM.assert_state(FSM.states.IDLE)):
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
		
func character_is_moving():
	return FSM.assert_state(FSM.states.HIT) or FSM.assert_state(FSM.states.LEFT) or FSM.assert_state(FSM.states.RIGHT)
	
func change_status(finished_animation):
	if character_is_moving():
		reset_status()

func reset_status():
	set_state(FSM.events.IDLE)

func frame_count():
	frame = frame + 1
	if (frame >= 60):
		frame = 0

func random_option(options):
	var num_options = count(options)
	randomize()
	var sel = (randi() % num_options) + 1
	return options[sel]

func assert_state(state):
	if get_state() != state:
		return false
	return true

func set_state(event):
	FSM.handle(event)

func get_state():
	return FSM.get_state()

func get_other_boxer_from_collision(area):
	if area.get_parent() != null and area.get_parent().get_parent() != null:
		return area.get_parent().get_parent()
	else:
		print("Unable to get other boxer from area")
		return 0