extends Node2D

var helper: Node = load('res://scripts/Helper.gd').new()
var player: AnimationPlayer
# signal playing_finished

onready var hud: Node = get_tree().get_root().get_node('World/Hud/PanelContainer/HBoxContainer')
onready var time: Node = hud.get_node('time')
onready var p1_score: Node = hud.get_node('p1_Score')
onready var p2_score: Node = hud.get_node('p2_Score')
onready var p1_stats: Node = hud.get_node('p1_Stats')
onready var p2_stats: Node = hud.get_node('p2_Stats')

func _ready():
	player = $UIAnimationPlayer

func _process(_delta: float):
	pass

func _update(score: Dictionary, timer: Timer):
	var t = helper.get_time_left_str(timer)
	time.set_text(t)
	p1_score.set_text(str(score['p1']))
	p2_score.set_text(str(score['p2']))

func show_game_over():
	if !player.is_playing():
		player.play('GameOver')

func show_count_down():
	if !player.is_playing():
		player.play('CountDown')

# func _on_UIAnimationPlayer_animation_finished(_anim_name):
# 	emit_signal('playing_finished')
