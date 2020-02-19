extends Node2D

const ROUND_START = 0
const RUNNING = 1
const GAME_OVER = 2
const GAME_DONE = 3
const PAUSE = 4

var Level: int = 1
var State = null
export var sound_on: bool = false
export var round_on: bool = false
export var round_time: int = 90

var fsm = load('res://scripts/FSM.gd').new()
var helper = load('res://scripts/Helper.gd').new()
var scoreManager = load('res://scripts/ScoreManager.gd').new()
onready var uiManager: Node = $UiManager
onready var audioManager: Node = $AudioManager
onready var Players: Dictionary = {'p1':$Canvas/Boxer, 'p2':$Canvas/Opponent}


func _ready():
	set_process(true)
	set_state(RUNNING)
	if sound_on: 
		$AudioManager/CrowdBackground.play()
	if round_on == true:
		set_state(ROUND_START)
	$Timer.start(round_time)
		
func _process(delta : float):
	match(get_state()):
		GAME_DONE:
			return
		GAME_OVER:
			do_game_over()
		ROUND_START:
			start_round()
		RUNNING:
			unpause_timer()
			start_players()
			continue
		_:
			update_state()
			scoreManager.save()
			uiManager._update(scoreManager.get_score_map(), $Timer)

func _input(event):
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_P):
			check_pause()
		if Input.is_key_pressed(KEY_Q):
			check_resign()
		if Input.is_action_pressed("exit"):
			quit()

func set_state(new_state :int):
	State = new_state

func get_state():
	return State

func update_state():
	if $Timer.time_left <= 0:
		set_state(GAME_OVER)

func quit():
	get_tree().quit()	

func start_round():
	pause_players()
	uiManager.show_count_down()
	# https://docs.godotengine.org/en/3.0/getting_started/scripting/gdscript/gdscript_basics.html?highlight=yield#coroutines-with-yield
	# This binds to UiManager which emits a signal ('playing_finished') 
	# when the player also emits its own signal to UiManager object
	yield(uiManager, "playing_finished")
	if sound_on: 
		$AudioManager/Bell.play()
	set_state(RUNNING)

func do_game_over():
	pause_players()
	uiManager.show_game_over()
	if sound_on: 
		$AudioManager/Bell.play()
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
		
func check_pause():
	if get_state() == RUNNING or get_state() == PAUSE:
		if get_state() != PAUSE:
			set_state(PAUSE)
			pause_players()
			pause_timer()
		else:
			set_state(RUNNING)

func pause_timer():
	$PauseOverlay.visible = true
	$Timer.paused = true

func unpause_timer():
	$PauseOverlay.visible = false
	$Timer.paused = false

func check_resign():
		$Timer.stop()

func is_sound_on():
	return sound_on
