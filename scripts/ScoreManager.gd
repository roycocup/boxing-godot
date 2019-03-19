var Cache = preload("res://scripts/Cache.gd").new()
var score_map = {'p1':0, 'p2':0, 'is_dirty':false}

func _init():
	Cache.cache_filename = 'res://scripts/Score.cache'

func save():
	if (score_map['is_dirty']):
		Cache.save(score_map)
		score_map['is_dirty'] = false

func update(player_data):
	# Player 1 just been hit so add a point to player 2
	if player_data['name'] == 'p1':
		score_map['p2'] += 1
	elif player_data['name'] == 'p2':
		score_map['p1'] += 1
	else:
		return
	score_map['is_dirty'] = true
	
func get_score_map():
	return score_map