extends Node2D

const RUNNING = 0
const GAME_OVER = 1
const ROUND_START = 2

var Level = 1
var State = ROUND_START

var fsm = load('res://scripts/FSM.gd').new()
var helper = load('res://scripts/Helper.gd').new()
var ui = load('res://scripts/UiManager.gd').new()
var score = load('res://scripts/ScoreManager.gd').new()
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/AI}
onready var UI = {
	'p1_score':$UI/HBoxContainer/MarginContainer/p1_Score,
	'p2_score':$UI/HBoxContainer/p2_Score,
	'time':$UI/HBoxContainer/MarginContainer2/time,
}

func _ready():
	set_process(true)
	#$Bell.play()

func _process(delta):
	quit_by_esc()
	update_state()
	if get_state() == GAME_OVER:
		# ui.show_game_over()
		Players['p1'].set_state(fsm.events.PAUSE)
		# Players['p2'].set_state(fsm.events.PAUSE)
	else:
		score.save()
		ui.update(UI, score.get_score_map(), $Timer)

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


		
	


