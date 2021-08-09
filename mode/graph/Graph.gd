extends GraphEdit


signal raise_request(name, type)


const GBlock = preload("res://mode/graph/GBlock.tscn");


func _checkError(err, msg):
	if err != OK:
		print("Failure ", msg, "! ", err);


func _ready():
	#get_node("Entity").connect("resize_request", self, "_on_Entity_resize_request")

	_checkError(
		connect('connection_request', self, '_on_connection_request'),
		"connecting Graph connection_request"
	);
	_checkError(
		connect('connection_from_empty', self, '_on_connection_from_empty'),
		"connecting Graph connection_from_empty"
	);
	_checkError(
		connect('connection_to_empty', self, '_on_connection_to_empty'),
		"connecting Graph connection_to_empty"
	);
	_checkError(
		connect('disconnection_request', self, '_on_disconnection_request'),
		"connecting Graph disconnection_request"
	);


func _on_Entity_dragged(from, to):
	print('Dragged from ', from, 'to ', to)


func _on_Entity_resize_request(new_minsize):
	print('Resize request ', new_minsize);


func _on_connection_request(from, from_slot, to, to_slot):
	_checkError(
		connect_node(from, from_slot, to, to_slot),
		"connecting nodes {0} [{1}] -> {2} [{3}]".format([from, from_slot, to, to_slot])
	);


func _on_connection_from_empty(to, to_slot, release_position):
	print('Connection from empty not supported yet! {2} -> {0} [{1}]'.format([release_position, to, to_slot]));


func _on_connection_to_empty(from, from_slot, release_position):
	print('Connection to empty not supported yet! {0} [{1}] -> {2}'.format([from, from_slot, release_position]));


func _on_disconnection_request(from, from_slot, to, to_slot):
	_checkError(
		disconnect_node(from, from_slot, to, to_slot),
		"disconnecting nodes {0} [{1}] -> {2} [{3}]".format([from, from_slot, to, to_slot])
	);


func _add_Block(
	#name='New',
	#entity='',
	#architecture='',
	#generic_map='',
	#size=Vector2(100, 75)
	position=Vector2(500, 250)
):
	var newBlock = GBlock.instance();
	newBlock.title = 'New entity instance';
	newBlock.set_offset(position)

	# TEST HOW TO ADD PORTS PROGRAMMATICALLY
	# Fetch list of ports from the database/resource/list of entities
	# For each port,
	var firstPort = Label.new()
	firstPort.text = 'First port'
	firstPort.owner = newBlock
	newBlock.add_child(firstPort)
	# Enable the slot (port_num + 2):
	#  - left enabled only if IN
	#  - right enabled only if OUT
	#  - both enabled if INOUT
	#  - get the 'type' index  from the database/resource/list of signal types
	
	newBlock.connect('raise_request', self, "_on_raise_request", [newBlock.title, 'instance'])
	
	add_child(newBlock)


func _on_raise_request(name, type):
	emit_signal('raise_request', name, type)
