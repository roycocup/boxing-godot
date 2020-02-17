onready var Cache = preload("res://scripts/Cache.gd").new()

var data = {}

func init_cache():
	Cache.cache_filename = 'res://scripts/AI.cache'
	# Cache.hidrate()

func build_tree():
	data = { 
		'decisions' : {},
		'states' : {'chase':0, 'evade':1, 'punch':2, 'idle':3},
	}
	data['cur_state'] = data['states']['idle']

func get_relative_status():
	return 'winning'

func _ready(_player_data):
	init_cache()
	build_tree()
	Cache.save(data)

func _process():
	# if started, chase. if winning, chase. if losing, evade.
	get_relative_status()
	


