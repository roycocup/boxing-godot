extends Node

var cache_filename = ''

func hidrate():
	var file = File.new()
	if not file.file_exists(cache_filename):
	    print("No file saved!")
	    return
	
	# Open existing file
	if file.open(cache_filename, File.READ) != 0:
	    print("Error opening file " + cache_filename)
	    return
	
	return parse_json(file.get_line())
	
func save(data):
	# Open a file
	var file = File.new()
	if file.open(cache_filename, File.WRITE) != 0:
	    print("Error opening file")
	    return
	
	# Save the dictionary as JSON (or whatever you want, JSON is convenient here because it's built-in)
	file.store_line(to_json(data))
	file.close()