extends Node2D

var Score = {'p1':0, 'p2':0, 'is_dirty':false}
var Level = 1
var game_over = false

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
	
func _process(delta):
	quit_by_esc()
	save_score()
	update_ui()



func quit_by_esc():
	if Input.is_action_pressed("exit"):
		get_tree().quit()

func get_time_left_str():
	var secs = fmod(round($Timer.time_left), 60)
	var minutes = floor($Timer.time_left/60)
	if (minutes <= 0): 
		minutes = 0
	secs = str(secs)
	minutes = str(minutes)
	if len(secs) < 2:
		secs = "0" + secs
	var time = str(minutes) + ":" + str(secs)
	return str(time)

func update_ui():
	UI['time'].text = get_time_left_str()
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


		
	


