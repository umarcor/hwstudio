extends Node


const Project = preload('res://data/Data_Project.gd')

var devices = {}
var libraries = {}
var projects = []

const backends = [
	'OSVB',
	'SymbiFlow',
	'Edalize',
	'Apio'
]

const gates = {
	'not': {
		'inputs': 1,
		'outputs': 1,
		'color': [0, 0, 1]
	},
	'and': {
		'inputs': 1,
		'outputs': 1,
		'color': [0, 1, 0]
	},
	'or': {
		'inputs': 1,
		'outputs': 1,
		'color': [1, 0, 0]
	},
	'xor': {
		'inputs': 1,
		'outputs': 1,
		'color': [1, 1, 0]
	},
	'nand': {
		'inputs': 1,
		'outputs': 1,
		'color': [0, 1, 1]
	},
	'nor': {
		'inputs': 1,
		'outputs': 1,
		'color': [1, 0, 1]
	},
	'xnor': {
		'inputs': 1,
		'outputs': 1,
		'color': [1, 1, 1]
	},
}


func _init():
	_load_Parts()
	_load_Boards()
	libraries.utils = {
		'entities': {},
		'architectures': {}
	}
	projects.append(Project.new('Example project', [
		Project.Source.new('/t/neorv32', Project.source_types.GLOB),
		Project.Source.new('/t/vunit/vunit', Project.source_types.GLOB),
		Project.Source.new('/t/vunit/osvb/AXI4Stream', Project.source_types.PYCAPI)
	]));


func _read_JSON(file):
	var fptr = File.new()
	fptr.open(file, File.READ)
	var content = JSON.parse(fptr.get_as_text())
	fptr.close()
	if content.error != OK:
		print('Failure _read_JSON: something went wrong; ! {0}'.format([content.error]));
		return
	return content.result


func _load_Parts():
	devices['hx1k'] = { 'name': 'HX1K', 'boards': {} };
	devices['up5k'] = { 'name': 'UP5K', 'boards': {}  };


func _load_Boards():
	var path = 'res://data/boards/'
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	var file = dir.get_next()
	while file != '':
		if file.ends_with('.json'):
			var content = _read_JSON('{0}{1}'.format([path, file]));
			var id = file.trim_suffix('.json');
			var part = content.part;
			content.erase(part);
			if id in devices[part].boards:
				print('Overwritting info of board ', content.name);
			devices[part].boards[id] = content;
		file = dir.get_next();


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
