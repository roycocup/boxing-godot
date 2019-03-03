extends Node2D

var helper = load('res://scripts/Helper.gd').new()
var player = null
signal playing_finished

onready var hud = get_tree().get_root().get_node('World/Hud/PanelContainer/HBoxContainer')

func _ready():
	player = $UIAnimationPlayer

func _process(delta):
	pass

func update(score, timer):
	var t = helper.get_time_left_str(timer)
	hud.get_node('time').set_text(t)
	hud.get_node('p1_Score').set_text(str(score['p1']))
	hud.get_node('p2_Score').set_text(str(score['p2']))

func show_game_over():
	if !player.is_playing():
		player.play('GameOver')

func show_count_down():
	if !player.is_playing():
		player.play('CountDown')

func _on_UIAnimationPlayer_animation_finished(anim_name):
	emit_signal('playing_finished')
