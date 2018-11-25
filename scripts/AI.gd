extends Node

onready var Cache = preload("res://scripts/Cache.gd").new()

var data = {}

func init_cache():
	Cache.cache_filename = 'res://scripts/AI.cache'
	Cache.save_data(data)
	# Cache.hidrate()

func _ready():
	init_cache()
	build_tree()
	print(data)

func build_tree():
	data = { 
		'decisions' : {},
		'states' : {'chase':0, 'evade':1, 'punch':2}
	}
	


