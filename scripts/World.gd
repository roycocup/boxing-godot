extends Node2D

onready var Cache = preload("res://scripts/Cache.gd").new()
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/AI}
var Score = {'p1':0, 'p2':0, 'is_dirty':false}
var Time = 90 # seconds
onready var UI = {
	'p1_score':$UI/HBoxContainer/MarginContainer/p1_Score,
	'p2_score':$UI/HBoxContainer/p2_Score,
	'time':$UI/HBoxContainer/MarginContainer2/time,
}

func _ready():
	set_process(true)
	Cache.cache_filename = 'res://scripts/World.cache'
	#$Bell.play()
	

func _process(delta):
	quit_by_esc()
	save_score()
	update_ui()
		
func quit_by_esc():
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func update_ui():
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


		
	


