extends Node


var view: int = -1


func _checkError(err, msg):
	if err != OK:
		print("Failure ", msg, "! ", err)


func _ready():
	_checkError($HUD.connect("context_pressed", self, "_on_ContextMenu_pressed"), "connecting $HUD/ContextMenu context_pressed")
	_checkError($HUD.connect("mode_pressed", self, "_switchMode"), "connecting $HUD mode_change");
	_checkError($Graph.connect('raise_request', self, "_on_raise_request"), "connecting $Graph raise_request")
	_switchMode($HUD._File_Mode_Spatial);


# FIXME: There should be a better solution to achieve this.
# We tried using a TabContainer. Unfortunately, the Spatial (3D) node seems to be always hidden behind the tab container.
func _switchMode(idx):
	if idx != null:
		if view == idx:
			return
		else:
			view = idx
	else:
		view = view+1 if view < 2 else 0;

	for item in [$Graph, $TileMap, $Spatial, $Spatial/Window]:
		item.hide()

	var hud = $HUD
	match view:
		hud._File_Mode_Graph:
			$Graph.show()
		hud._File_Mode_TileMap:
			$TileMap.show()
		hud._File_Mode_Spatial:
			$Spatial.show()
			$Spatial/Window.show()


func _on_ContextMenu_pressed(idx):
	var hud = $HUD
	match idx:
		hud._File_Add:
			$Graph._add_Block()
		hud._File_Save:
			for child in $Graph.get_children():
				if child is GNode:
					print('Entity: ', child.get_class(), ' ', child.title if 'title' in child else '')
					continue
				if child is GraphNode:
					print('GraphNode: ', child.get_class(), ' ', child.title if 'title' in child else '')


func _on_raise_request(name, type):
	$HUD/Menu/TabContainer/Placeholder/VSplitContainer/Details.update_details(name, type)


func _input(_ev: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_switch_view"):
		_switchMode(null)
	#if ev.is_action_pressed("click"):
	#if ev is InputEventMouseButton:
		#print(
		#	'Mouse pressed!',
		#	'Button: ', ev.button_index,
		#	'isDBClick: ', ev.doubleclick
		#)
		#var new_ball = Ball.instance()
		#new_ball.position = get_viewport().get_mouse_position()
		#add_child(new_ball)


func _unhandled_input(ev: InputEvent) -> void:
	if ev is InputEventMouseMotion:
		return
	if ev is InputEventKey and (ev.scancode == KEY_CONTROL or ev.scancode == KEY_TAB):
		return
	#print("_unhandled_input: ", ev)

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
