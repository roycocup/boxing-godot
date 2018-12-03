extends Node2D

onready var Cache = preload("res://scripts/Cache.gd").new()
onready var Players = {'p1':$Canvas/Boxer, 'p2':$Canvas/AI}
var Score = {'p1':0, 'p2':0, 'is_dirty':false}
var Time = 90 # seconds


func _ready():
	set_process(true)
	Cache.cache_filename = 'res://scripts/World.cache'

func _process(delta):
	quit_by_esc()
	save_score()
		
func quit_by_esc():
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
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
	print(Score)
	Score['is_dirty'] = true


		
	


