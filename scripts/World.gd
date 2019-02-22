extends Node2D

const ROUND_START = 0
const RUNNING = 1
const GAME_OVER = 2
const GAME_DONE = 3

var Level = 1
var State = null

var fsm = load('res://scripts/FSM.gd').new()
var helper = load('res://scripts/Helper.gd').new()
var score = load('res://scripts/ScoreManager.gd').new()
onready var uiManager = load('res://scripts/UiManager.gd').new(get_tree())
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/AI}
onready var UI = {
	'p1_score':$UI/HBoxContainer/MarginContainer/p1_Score,
	'p2_score':$UI/HBoxContainer/p2_Score,
	'time':$UI/HBoxContainer/MarginContainer2/time,
}

func _ready():
	set_process(true)
	set_state(ROUND_START)

func _process(delta):
	quit_by_esc()
	match(get_state()):
		GAME_DONE:
			return
		GAME_OVER:
			do_game_over()
		ROUND_START:
			start_round()
		RUNNING:
			continue
		_:
			update_state()
			score.save()
			uiManager.update(UI, score.get_score_map(), $Timer)

func set_state(new_state):
	State = new_state

func get_state():
	return State

func update_state():
	if $Timer.time_left <= 0:
		set_state(GAME_OVER)

func quit():
	get_tree().quit()
	
func quit_by_esc():
	if Input.is_action_pressed("exit"):
		quit()

func start_round():
	# play animations for round etc
	$Bell.play()
	set_state(RUNNING)

func do_game_over():
	uiManager.show_game_over()
	Players['p1'].set_state(fsm.events.PAUSE)
	Players['p2'].set_state(fsm.events.PAUSE)
	$Bell.play()
	set_state(GAME_DONE)
