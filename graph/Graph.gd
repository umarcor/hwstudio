extends GraphEdit


const GBlock = preload("res://graph/GBlock.tscn")


signal raise_request(name, type)


#-- Ready


func _ready():
	#get_node("Entity").connect("resize_request", self, "_on_Entity_resize_request")

	connect('connection_request', self, '_on_connection_request')
	connect('connection_from_empty', self, '_on_connection_from_empty')
	connect('connection_to_empty', self, '_on_connection_to_empty')
	connect('disconnection_request', self, '_on_disconnection_request')


#--- Moving/dragging and resizing


func _on_Entity_dragged(from, to):
	print('Dragged from ', from, 'to ', to)
	#pass # Replace with function body.


func _on_Entity_resize_request(new_minsize):
	print('Resize request ', new_minsize)
	#pass # Replace with function body.


#-- Connections


func _on_connection_request(from, from_slot, to, to_slot):
	print(
		'Connection request: ' +
		str(from) + ' [' + str(from_slot) + '] -> ' +
		str(to) + ' [' + str(to_slot) + ']'
	)
	connect_node(from, from_slot, to, to_slot)
	#pass # Replace with function body.


func _on_connection_from_empty(from, from_slot, release_position):
	print(
		'Connection from empty not supported yet! ' +
		str(from) + ' [' + str(from_slot) + '] -> ' +
		str(release_position)
	)


func _on_connection_to_empty(from, from_slot, release_position):
	print(
		'Connection to empty not supported yet! ' +
		str(from) + ' [' + str(from_slot) + '] -> ' +
		str(release_position)
	)


func _on_disconnection_request(from, from_slot, to, to_slot):
	print(
		'Disconnection request: ' +
		str(from) + ' [' + str(from_slot) + '] -> ' +
		str(to) + ' [' + str(to_slot) + ']'
	)
	disconnect_node(from, from_slot, to, to_slot)


#---


func _add_Block(
	name='New',
	entity='',
	architecture='',
	generic_map='',
	position=Vector2(500, 250),
	size=Vector2(100, 75)
):
	var newBlock: GBlock = GBlock.instance()
	newBlock.title = 'New entity instance'
	
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

