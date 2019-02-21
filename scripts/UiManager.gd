extends Node

var helper = load('res://scripts/Helper.gd').new()

func update(UI, score, timer):
	UI['time'].text = helper.get_time_left_str(timer)
	UI['p1_score'].text = str(score['p1'])
	UI['p2_score'].text = str(score['p2'])