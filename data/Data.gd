extends Node


var devices = {}
var libraries = {}


const gates = {
	"not": {
		"inputs": 1,
		"outputs": 1,
		"color": [0, 0, 1]
	},
	"and": {
		"inputs": 1,
		"outputs": 1,
		"color": [0, 1, 0]
	},
	"or": {
		"inputs": 1,
		"outputs": 1,
		"color": [1, 0, 0]
	},
	"xor": {
		"inputs": 1,
		"outputs": 1,
		"color": [1, 1, 0]
	},
	"nand": {
		"inputs": 1,
		"outputs": 1,
		"color": [0, 1, 1]
	},
	"nor": {
		"inputs": 1,
		"outputs": 1,
		"color": [1, 0, 1]
	},
	"xnor": {
		"inputs": 1,
		"outputs": 1,
		"color": [1, 1, 1]
	},
}


func _checkError(err, msg):
	if err != OK:
		print("Failure ", msg, "! ", err);
		return true;
	return false;


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
	if _checkError(content.error, '_read_JSON: something went wrong; '):
		return
	return content.result


func _load_Parts():
	devices["hx1k"] = { "name": "HX1K", "boards": {} };
	devices["up5k"] = { "name": "UP5K", "boards": {}  };


func _load_Boards():
	var path = 'res://data/boards/'
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


# THIS IS A TEST TO READ AN `.ice` FILE
#	var iceFile = File.new()
#	iceFile.open('/hwstudio/godot/examples/ice/test.ice', File.READ)
#	var iceContent = parse_json(iceFile.get_as_text())
#	iceFile.close()
#	var iceBlocks = iceContent.design.graph.blocks
#	print(iceBlocks)
#	var design = {
#		'blocks': []
#	}
#	for block in iceBlocks:
#		design.blocks.append({
#			'name': block.id,
#			'entity': block.type,
#			'arch': '',
#			'const': {},
#			'pos':  Vector2(block.position.x, block.position.y),
#			'size': Vector2(block.size.width, block.size.height) if 'size' in block else null
#		})
#	print(design)
