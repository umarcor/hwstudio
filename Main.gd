extends Node

const Data = preload("res://data/Data.gd")

var data: Data

func _ready():
	print('Main is ready!')

	data = Data.new()
	data.print_device_list()

	$HUD/Boards.update_devices(data.devices)

	# Godot signal connections
	$HUD/MenuFile.get_popup().connect("id_pressed", self, "_on_FileMenu_pressed")
	$HUD/RepositoriesButton.connect("toggled", self, "_on_RepositoriesButton_toggled")
	$HUD/BoardsButton.connect("toggled", self, "_on_BoardsButton_toggled")
	$About/PanelContainer/CenterContainer/VBoxContainer/CenterContent/VBoxContent/HBoxData/VBoxValues/DocLink.connect("pressed", self, "_on_Doc_pressed")
	$Graph.connect('raise_request', self, "_on_raise_request")

	$About.hide()
	$HUD/RepositoriesButton.pressed = true
	$HUD/BoardsButton.pressed = true

#func _input(event):
	#if event.is_action_pressed("click"):
	#if event is InputEventMouseButton:
		#print(
		#	'Mouse pressed!',
		#	'Button: ', event.button_index,
		#	'isDBClick: ', event.doubleclick
		#)
		#var new_ball = Ball.instance()
		#new_ball.position = get_viewport().get_mouse_position()
		#add_child(new_ball)

func _on_RepositoriesButton_toggled(st):
	if st:
		$HUD/Repositories.show()
	else:
		$HUD/Repositories.hide()


func _on_BoardsButton_toggled(st):
	if st:
		$HUD/Boards.show()
	else:
		$HUD/Boards.hide()


func _on_FileMenu_pressed(idx):
	var hud = $HUD
	match idx:
		hud._File_Add:
			$Graph._add_Block()
		hud._File_Docs:
			_on_Doc_pressed()
		hud._File_About:
			$About.show()
		hud._File_Save:
			for child in $Graph.get_children():
				if child is GNode:
					print('Entity: ', child.get_class(), ' ', child.title if 'title' in child else '')
					continue
				if child is GraphNode:
					print('GraphNode: ', child.get_class(), ' ', child.title if 'title' in child else '')


func _on_Doc_pressed():
	OS.shell_open("https://umarcor.github.io/hwstudio/doc")


func _on_raise_request(name, type):
	$HUD/Repositories/VSplitContainer/Details.update_details(name, type)
