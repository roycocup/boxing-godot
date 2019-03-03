extends Node2D

const ROUND_START = 0
const RUNNING = 1
const GAME_OVER = 2
const GAME_DONE = 3

var Level = 1
var State = null
export var sound_on = false
export var round_on = false

var fsm = load('res://scripts/FSM.gd').new()
var helper = load('res://scripts/Helper.gd').new()
var score = load('res://scripts/ScoreManager.gd').new()
onready var uiManager = $UiManager
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/Opponent}


func _ready():
	set_process(true)
	set_state(RUNNING)
	if round_on == true:
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
			start_players()
			continue
		_:
			update_state()
			score.save()
			uiManager.update(score.get_score_map(), $Timer)

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
	pause_players()
	uiManager.show_count_down()
	# https://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html?highlight=yield#coroutines-with-yield
	# This binds to UiManager which emits a signal ('playing_finished') 
	# when the player also emits its own signal to UiManager object
	yield(uiManager, "playing_finished")
	if sound_on: $Bell.play()
	set_state(RUNNING)
	
func do_game_over():
	pause_players()
	uiManager.show_game_over()
	if sound_on: $Bell.play()
	set_state(GAME_DONE)
	
func start_players():
	if !Players['p1'].assert_state(fsm.events.IDLE):
		Players['p1'].set_state(fsm.events.IDLE)
	if !Players['p2'].assert_state(fsm.events.IDLE):
		Players['p2'].set_state(fsm.events.IDLE)

func pause_players():
	if !Players['p1'].assert_state(fsm.events.PAUSE):
		Players['p1'].set_state(fsm.events.PAUSE)
	if !Players['p2'].assert_state(fsm.events.PAUSE):
		Players['p2'].set_state(fsm.events.PAUSE)

