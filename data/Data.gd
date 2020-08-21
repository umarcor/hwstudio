class_name Data


var devices = {}
var libraries = {}


func _init():
	_load_Parts()
	_load_Boards()
	libraries.utils = {
		'entities': {},
		'architectures': {}
	}


func _read_JSON(file):
	var fptr = File.new()
	fptr.open(file, File.READ)
	var content = JSON.parse(fptr.get_as_text())
	fptr.close()
	if content.error != OK:
		print('_read_JSON: something went wrong; ', content.error)
		return
	return content.result


func _load_Parts():
	var path = 'res://data/parts/'
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	var file = dir.get_next()
	while file != '':
		if file.ends_with('.json'):
			var id = file.trim_suffix('.json')
			devices[id] = _read_JSON(path + file)
			devices[id].boards = {}
		file = dir.get_next()


func _load_Boards():
	var path = 'res://data/devices/'
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	var file = dir.get_next()
	while file != '':
		if file.ends_with(".json"):
			var content = _read_JSON(path + file)
			var id = file.trim_suffix('.json')
			var part = content.part
			content.erase(part)
			if id in devices[part].boards:
				print('Overwritting info of board ', content.name)
			devices[part].boards[id] = content
		file = dir.get_next()


func print_device_list():
	print('Devices:')
	for device in devices:
		print('- ', device)
		for board in devices[device].boards:
			print('  - ', board)
