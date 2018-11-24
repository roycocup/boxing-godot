extends Node

var Yaml = preload("res://addons/godot-yaml/gdyaml.gdns").new()
var yml_filename = ''

func read():
	var file = File.new()
	if not file.file_exists(yml_filename):
	    print("No file found!")
	    return
	
	if file.open(yml_filename, File.READ) != 0:
	    print("Error opening file")
	    return
		
	var s = file.get_as_text()
	file.close()
	return Yaml.parse(s)
	

func save(data):
	var file = File.new()
	if file.open(yml_filename, File.WRITE) != 0:
	    print("Error opening file")
	    return
		
	file.store_string(Yaml.print(data))
	file.close()
	
