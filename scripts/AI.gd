extends Node

onready var Cache = preload("res://scripts/Cache.gd").new()
onready var yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()

var data = {
	    player_level = 42,
	    last_item = "sword"
	}

func _ready():
	print('AI')
	Cache.cache_filename = 'res://scripts/AI.cache'
	Cache.save_data(data)
	Cache.hidrate()

func read_decision_tree():
	Cache
	pass


