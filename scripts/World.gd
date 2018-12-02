extends Node2D

var Score = {'p1':0, 'p2':0, 'is_dirty':false}
var Time = 90 # seconds
onready var Cache = preload("res://scripts/Cache.gd").new()

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
	if player_data['name'] == 'p2':
		Score['p1'] = Score['p1'] + 1
	else:
		print(player_data['name'])
		return 
	Score['is_dirty'] = true
		
	


