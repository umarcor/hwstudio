extends Node


var currentMode: int = -1


func _ready():
	Utils._checkError(
		$HUD.connect("context_pressed", self, "_on_ContextMenu_pressed"),
		"connecting $HUD/ContextMenu context_pressed"
	);
	Utils._checkError(
		$HUD.connect("mode_pressed", self, "_switchMode"),
		"connecting $HUD mode_change"
	);
	Utils._checkError(
		$Graph.connect('raise_request', self, "_on_raise_request"),
		"connecting $Graph raise_request"
	);
	_switchMode($HUD.Mode.SPATIAL);


# FIXME: There should be a better solution to achieve this.
# We tried using a TabContainer. Unfortunately, the Spatial (3D) node seems to be always hidden behind the tab container.
func _switchMode(idx):
	if idx != null:
		if currentMode == idx:
			return
		else:
			currentMode = idx
	else:
		currentMode = currentMode+1 if currentMode < 2 else 0;

	for item in [$Graph, $TileMap, $Spatial, $Spatial/Window]:
		item.hide()

	var hud = $HUD
	match currentMode:
		hud.Mode.GRAPH:
			$Graph.show()
		hud.Mode.TILEMAP:
			$TileMap.show()
		hud.Mode.SPATIAL:
			$Spatial.show()
			$Spatial/Window.show()


func _on_ContextMenu_pressed(idx : int):
	var hud = $HUD
	match idx:
		hud.Context.ADD:
			$Graph._add_Block()
		hud.Context.SAVE:
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
