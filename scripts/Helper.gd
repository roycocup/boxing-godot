extends Node2D

func get_time_left_str(timer):
	var secs = fmod(round(timer.time_left), 60)
	var minutes = floor(timer.time_left/60)
	if (minutes <= 0):
		minutes = 0
	secs = str(secs)
	minutes = str(minutes)
	if len(secs) < 2:
		secs = "0" + secs
	var time = str(minutes) + ":" + str(secs)
	return str(time)