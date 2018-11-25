extends Node2D

var Score = {'p1':0, 'p2':0}
var Time = 90 # seconds


func _ready():
	set_process(true)

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		

func update_score(player_num):
	# Player 1 just been hit so add a point to player 2
	if player_num == 1:
		Score['p2'] = Score['p2'] + 1
	if player_num == 2:
		Score['p1'] = Score['p1'] + 1
	else:
		return 
		
	


