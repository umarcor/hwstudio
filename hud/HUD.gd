extends Node

const _File_New = 0
const _File_Open = 1
const _File_Add = 2
const _File_Save = 5
const _File_SaveAs = 6
const _File_Export = 7
const _File_Docs = 8
const _File_About = 9
const _File_Quit = 10

func _ready():

	var fmenuopts = $MenuFile.get_popup()
	fmenuopts.add_item('New', _File_New)
	fmenuopts.add_item('Open...', _File_Open)
	fmenuopts.add_item('Add', _File_Add)
	fmenuopts.add_separator()
	fmenuopts.add_item('Save', _File_Save)
	fmenuopts.add_item('Save as...', _File_SaveAs)
	fmenuopts.add_item('Export', _File_Export)
	fmenuopts.add_separator()
	fmenuopts.add_item('Docs', _File_Docs)
	fmenuopts.add_item('About', _File_About)
	fmenuopts.add_separator()
	fmenuopts.add_item('Quit', _File_Quit)

	fmenuopts.connect("id_pressed", self, "_on_FileMenu_pressed")

	$FileDialog.connect('confirmed', self, "_on_confirmed")
	$FileDialog.connect('dir_selected', self, "_on_dir_selected")
	$FileDialog.connect('file_selected', self, "_on_file_selected")
	$FileDialog.connect('files_selected', self, "_on_files_selected")


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


func _on_FileMenu_pressed(idx):
	match idx:
		_File_Open:
			$FileDialog.show()

		_File_Add:
			continue
		_File_Docs:
			continue
		_File_About:
			# Handled in Main
			return

		_:
			print('HUD/File: unhandled button pressed ' + str(idx))


func _on_dir_selected(dir):
	print('Dir selected: ', dir)


func _on_file_selected(file):
	print('File selected: ', file)


func _on_files_selected(files):
	print('Files selected: ', files)

