extends Node2D

onready var world = get_tree().get_root().get_node("World")
onready var scoreMananager = world.scoreManager
	
func _process(_delta):
	check_wow_sounds()


func check_wow_sounds():
	var scoreMap = scoreMananager.get_score_map()
	if (scoreMap['p1'] != 0 and scoreMap['p1'] % 10 == 0):
		$crowdWow1.play()
	if (scoreMap['p1'] != 0 and scoreMap['p1'] % 6 == 0):
		$crowdWow2.play()
