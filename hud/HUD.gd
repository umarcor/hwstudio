extends Node


signal context_pressed(idx)
signal mode_pressed(idx)

enum Context {
	MENU,
	MODE,
	NEW,
	OPEN,
	ADD,
	SAVE,
	SAVEAS,
	EXPORT,
	DOCS,
	ABOUT,
	QUIT
}

enum Mode {
	GRAPH,
	TILES,
	SPATIAL
}

var contextMenu = PopupMenu.new();
var modeMenu = PopupMenu.new();
onready var prefBackend : Node = $Menu/TabContainer/Preferences/Scroll/Sections/Backend;
onready var aboutLinks : Node = $About/PanelContainer/CenterContainer/VBoxContainer/CenterContent/VBoxContent/HBoxData/VBoxValues;


func _ready():
	modeMenu.set_name('modeMenu');
	modeMenu.add_item('Graph', Mode.GRAPH);
	modeMenu.add_item('Tiles', Mode.TILES);
	modeMenu.add_item('Spatial', Mode.SPATIAL);
	contextMenu.add_child(modeMenu);

	Utils.checkError(
		modeMenu.connect('id_pressed', self, '_on_ModeMenu_pressed'),
		'connecting modeMenu id_pressed'
	);

	contextMenu.set_name('ContextMenu');
	add_child(contextMenu);
	contextMenu.add_item('Menu...', Context.MENU);
	contextMenu.add_submenu_item('Mode', 'modeMenu', Context.MODE);
	contextMenu.add_separator();
	contextMenu.add_item('New', Context.NEW);
	contextMenu.add_item('Open...', Context.OPEN);
	contextMenu.add_item('Add', Context.ADD);
	contextMenu.add_separator();
	contextMenu.add_item('Save', Context.SAVE);
	contextMenu.add_item('Save as...', Context.SAVEAS);
	contextMenu.add_item('Export', Context.EXPORT);
	contextMenu.add_separator();
	contextMenu.add_item('Docs', Context.DOCS);
	contextMenu.add_item('About', Context.ABOUT);
	contextMenu.add_separator();
	contextMenu.add_item('Quit', Context.QUIT);

	Utils.checkError(
		contextMenu.connect('id_pressed', self, '_on_ContextMenu_pressed'),
		'connecting contextMenu id_pressed'
	);

	Utils.checkError($FileDialog.connect(
		'confirmed', self, '_on_confirmed'),
		'connecting $FileDialog confirmed'
	);
	Utils.checkError(
		$FileDialog.connect('dir_selected', self, '_on_dir_selected'),
		'connecting $FileDialog dir_selected'
	);
	Utils.checkError(
		$FileDialog.connect('file_selected', self, '_on_file_selected'),
		'connecting $FileDialog file_selected'
	);
	Utils.checkError(
		$FileDialog.connect('files_selected', self, '_on_files_selected'),
		'connecting $FileDialog files_selected'
	);

	Utils.checkError(
		aboutLinks.get_node('RepoLink').connect('pressed', self, '_on_RepoLink_pressed'),
		'connecting $About...RepoLink pressed'
	);
	Utils.checkError(
		aboutLinks.get_node('DocLink').connect('pressed', self, '_on_DocLink_pressed'),
		'connecting $About...DocLink pressed'
	);

	$Menu.hide();
	$Menu/TabContainer/Boards.update_devices(Data.devices);

	Utils.checkError(
		prefBackend.get_node('Address/Test').connect('pressed', self, '_on_Backend_Test_pressed'),
		'connecting $Menu...Backend...Test pressed'
	);
	Utils.checkError(
		Utils.APIRequest.connect('request_completed', self, '_on_HTTPRequest_completed'),
		'connecting $HTTPRequest request_completed'
	);

	$About.hide();


func _on_Backend_Test_pressed():
	var call = 'http://{0}/things'.format([prefBackend.get_node('Address/LineEdit').text])
	print('We are testing the connection to the backend [{0}]...'.format([call]));
	Utils.checkError(
		Utils.APIRequest.request(call),
		'requesting {0}'.format([call])
	);


func _on_HTTPRequest_completed(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	#var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)


func _on_ModeMenu_pressed(idx : int):
	emit_signal('mode_pressed', idx)


func _on_ContextMenu_pressed(idx : int):
	match idx:
		Context.MENU:
			_switch_pause($Menu, true);

		Context.OPEN:
			$FileDialog.show();

		Context.DOCS:
			_on_DocLink_pressed();

		Context.ABOUT:
			_switch_pause($About, true);

		Context.ADD:
			# Handled in Main
			emit_signal('context_pressed', idx);
			return

		_:
			print('HUD/contextMenu: unhandled button pressed {0}'.format([idx]));


func _on_dir_selected(dir):
	print('Dir selected: ', dir)

func _on_file_selected(file):
	print('File selected: ', file)

func _on_files_selected(files):
	print('Files selected: ', files)


func _on_DocLink_pressed():
	Utils.checkError(
		OS.shell_open('https://umarcor.github.io/hwstudio/doc'),
		'opening URL umarcor.github.io/hwstudio/doc'
	);

func _on_RepoLink_pressed():
	Utils.checkError(
		OS.shell_open('https://github.com/umarcor/hwstudio'),
		'opening URL github.com/umarcor/hwstudio'
	);


func _switch_pause(
	node: Node,
	val : bool
):
	if val:
		get_tree().paused = true;
		node.show();
	else:
		node.hide();
		get_tree().paused = false;


func _unhandled_input(_ev: InputEvent) -> void:
	if Input.is_action_just_pressed('ui_context_menu'):
		contextMenu.rect_position = contextMenu.get_global_mouse_position();
		contextMenu.popup();
	elif Input.is_action_just_pressed('ui_cancel'):
		if $About.visible:
			_switch_pause($About, false);
			get_node('/root').set_input_as_handled();
		elif $Menu.visible and not contextMenu.visible:
			_switch_pause($Menu, false);
			get_node('/root').set_input_as_handled();
