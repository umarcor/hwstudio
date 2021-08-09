extends Node


signal context_pressed(idx)
signal mode_pressed(idx)


const _File_Menu = 0
const _File_Mode = 1
const _File_New = 2
const _File_Open = 3
const _File_Add = 4
const _File_Save = 5
const _File_SaveAs = 6
const _File_Export = 7
const _File_Docs = 8
const _File_About = 9
const _File_Quit = 10

const _File_Mode_Graph = 0
const _File_Mode_TileMap = 1
const _File_Mode_Spatial = 2

var contextMenu = PopupMenu.new();
var modeMenu = PopupMenu.new();
var prefBackend : Node;
var aboutLinks : Node;


func _checkError(err, msg):
	if err != OK:
		print("Failure ", msg, " ", err)
		

func _ready():
	
	prefBackend = $Menu/TabContainer/Preferences/Scroll/Sections/Backend;
	aboutLinks = $About/PanelContainer/CenterContainer/VBoxContainer/CenterContent/VBoxContent/HBoxData/VBoxValues;
	
	modeMenu.set_name("modeMenu");
	modeMenu.add_item('Graph', _File_Mode_Graph);
	modeMenu.add_item('TileMap', _File_Mode_TileMap);
	modeMenu.add_item('Spatial', _File_Mode_Spatial);
	contextMenu.add_child(modeMenu);

	_checkError(modeMenu.connect("id_pressed", self, "_on_ModeMenu_pressed"), "connecting modeMenu id_pressed");

	contextMenu.set_name("ContextMenu");
	add_child(contextMenu);
	contextMenu.add_item('Menu...', _File_Menu);
	contextMenu.add_submenu_item('Mode', "modeMenu", _File_Mode);
	contextMenu.add_separator();
	contextMenu.add_item('New', _File_New);
	contextMenu.add_item('Open...', _File_Open);
	contextMenu.add_item('Add', _File_Add);
	contextMenu.add_separator();
	contextMenu.add_item('Save', _File_Save);
	contextMenu.add_item('Save as...', _File_SaveAs);
	contextMenu.add_item('Export', _File_Export);
	contextMenu.add_separator();
	contextMenu.add_item('Docs', _File_Docs);
	contextMenu.add_item('About', _File_About);
	contextMenu.add_separator();
	contextMenu.add_item('Quit', _File_Quit);

	_checkError(contextMenu.connect("id_pressed", self, "_on_ContextMenu_pressed"), "connecting contextMenu id_pressed");

	_checkError($FileDialog.connect('confirmed', self, "_on_confirmed"), "connecting $FileDialog confirmed");
	_checkError($FileDialog.connect('dir_selected', self, "_on_dir_selected"), "connecting $FileDialog dir_selected");
	_checkError($FileDialog.connect('file_selected', self, "_on_file_selected"), "connecting $FileDialog file_selected");
	_checkError($FileDialog.connect('files_selected', self, "_on_files_selected"), "connecting $FileDialog files_selected");

	_checkError(aboutLinks.get_node("RepoLink").connect("pressed", self, "_on_RepoLink_pressed"), "connecting $About...RepoLink pressed")
	_checkError(aboutLinks.get_node("DocLink").connect("pressed", self, "_on_DocLink_pressed"), "connecting $About...DocLink pressed")

	$Menu.hide();
	$Menu/TabContainer/Boards.update_devices(Data.devices);

	_checkError(prefBackend.get_node("Address/Test").connect("pressed", self, "_on_Backend_Test_pressed"), "connecting $Menu...Backend...Test pressed");
	_checkError($HTTPRequest.connect("request_completed", self, "_on_HTTPRequest_completed"), "connecting $HTTPRequest request_completed");

	$About.hide();


func _on_Backend_Test_pressed():
	var addr = prefBackend.get_node("Address/LineEdit").text;
	print('We are testing the connection to the backend [{0}]...'.format([addr]));
	$HTTPRequest.request("http://{0}/things".format([addr]));


func _on_HTTPRequest_completed(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(headers)
	print(body.get_string_from_utf8())
	#var json = JSON.parse(body.get_string_from_utf8())
	#print(json.result)


func _on_ModeMenu_pressed(idx):
	emit_signal('mode_pressed', idx)


func _on_ContextMenu_pressed(idx):
	match idx:
		_File_Menu:
			$Menu.show();

		_File_Open:
			$FileDialog.show()

		_File_Docs:
			_on_DocLink_pressed()
			
		_File_About:
			$About.show()
			
		_File_Add, _File_Docs:
			# Handled in Main
			emit_signal('context_pressed', idx)
			return

		_:
			print('HUD/contextMenu: unhandled button pressed ' + str(idx))


func _on_dir_selected(dir):
	print('Dir selected: ', dir)

func _on_file_selected(file):
	print('File selected: ', file)

func _on_files_selected(files):
	print('Files selected: ', files)


func _on_DocLink_pressed():
	_checkError(OS.shell_open("https://umarcor.github.io/hwstudio/doc"), "opening URL umarcor.github.io/hwstudio/doc")

func _on_RepoLink_pressed():
	_checkError(OS.shell_open("https://github.com/umarcor/hwstudio"), "opening URL github.com/umarcor/hwstudio")


func _unhandled_input(_ev: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_context_menu"):
		contextMenu.rect_position = contextMenu.get_global_mouse_position();
		contextMenu.popup();
	elif Input.is_action_just_pressed("ui_cancel"):
		if $About.visible:
			$About.hide();
			#get_node('/root').set_input_as_handled();
		elif not contextMenu.visible:
			$Menu.visible = false #not $Menu.visible
			#get_node('/root').set_input_as_handled();
