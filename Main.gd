extends Node


var modeGroups = []
var currentMode: int = -1


func _ready():
	Utils._checkError(
		$HUD.connect("context_pressed", self, "_on_ContextMenu_pressed"),
		"connecting $HUD/ContextMenu context_pressed"
	);
	Utils._checkError(
		$HUD.connect("mode_pressed", self, "_switch_mode"),
		"connecting $HUD mode_change"
	);
	Utils._checkError(
		$Graph.connect('raise_request', self, "_on_raise_request"),
		"connecting $Graph raise_request"
	);

	modeGroups = {
		"graph": [$Graph],
		"tilemap": [$TileMap],
		"spatial": [$Spatial, $Spatial/Window]
	};
	for group in modeGroups:
		for item in modeGroups[group]:
			item.add_to_group(group);

	_switch_mode($HUD.Mode.SPATIAL);


# FIXME: There should be a better solution to achieve this.
# We tried using a TabContainer. Unfortunately, the Spatial (3D) node seems to be always hidden behind the tab container.
func _switch_mode(idx : int):
	if currentMode == idx:
		return
	currentMode = posmod(idx, modeGroups.size());

	for group in modeGroups:
		get_tree().call_group(group, "hide")

	var mode = $HUD.Mode;
	var group = '';
	match currentMode:
		mode.GRAPH:
			group = "graph";
		mode.TILEMAP:
			group = "tilemap";
		mode.SPATIAL:
			group = "spatial";
	get_tree().call_group(group, "show");


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
	if Input.is_action_just_pressed("ui_switch_prev"):
		_switch_mode(currentMode-1);
	elif Input.is_action_just_pressed("ui_switch_next"):
		_switch_mode(currentMode+1);
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
