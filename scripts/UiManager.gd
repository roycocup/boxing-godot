extends Node

var helper = load('res://scripts/Helper.gd').new()
var player = null

func _init(tree):
	player = tree.get_root().get_node('/root/World/UIAnimationPlayer')

func update(UI, score, timer):
	UI['time'].text = helper.get_time_left_str(timer)
	UI['p1_score'].text = str(score['p1'])
	UI['p2_score'].text = str(score['p2'])

func show_game_over():
	if !player.is_playing():
		player.play('GameOver')

func show_count_down():
	if !player.is_playing():
		player.play('CountDown')

