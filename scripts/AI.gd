extends Node

onready var Cache = preload("res://scripts/Cache.gd").new()
onready var Yml = preload("res://scripts/Yml.gd").new()

var data = {}

func init_cache():
	Cache.cache_filename = 'res://scripts/AI.cache'
	Cache.save_data(data)
	Cache.hidrate()

func _ready():
	Yml.yml_filename = 'res://scripts/AiDecisionTree.yml'
	var t = Yml.read()
	print(t)

func read_decision_tree():
	pass


