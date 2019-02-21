extends Node2D

var Score = {'p1':0, 'p2':0, 'is_dirty':false}
var Level = 1
const RUNNING = 0
const GAME_OVER = 1
const ROUND_START = 2
var State = ROUND_START
var helper = load('res://scripts/Helper.gd').new()

onready var Cache = preload("res://scripts/Cache.gd").new()
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/AI}
onready var UI = {
	'p1_score':$UI/HBoxContainer/MarginContainer/p1_Score,
	'p2_score':$UI/HBoxContainer/p2_Score,
	'time':$UI/HBoxContainer/MarginContainer2/time,
}

func _ready():
	set_process(true)
	Cache.cache_filename = 'res://scripts/World.cache'
	#$Bell.play()

func update_state():
	if $Timer.time_left <= 0:
		set_state(GAME_OVER) 

func _process(delta):
	quit_by_esc()
	update_state()
	if get_state() == GAME_OVER:
		$GameOverOverlay/AnimationPlayer.play('GameOver')
	else:
		save_score()
		update_ui()

func set_state(new_state):
	State = new_state

func get_state():
	return State

func quit():
	get_tree().quit()
	
func quit_by_esc():
	if Input.is_action_pressed("exit"):
		quit()


func update_ui():
	UI['time'].text = helper.get_time_left_str($Timer)
	UI['p1_score'].text = str(Score['p1'])
	UI['p2_score'].text = str(Score['p2'])
	
func save_score():
	if (Score['is_dirty']):
		Cache.save(Score)
		Score['is_dirty'] = false

func update_score(player_data):
	# Player 1 just been hit so add a point to player 2
	if player_data['name'] == 'p1':
		Score['p2'] = Score['p2'] + 1
	elif player_data['name'] == 'p2':
		Score['p1'] = Score['p1'] + 1
	else:
		return
	Score['is_dirty'] = true


		
	


