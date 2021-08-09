extends Tabs


var pmenu
var bmenu

var devices
var selected_part
var selected_board


func _ready():
	pmenu = $VBoxContainer/HBoxContainer/SelectPart
	bmenu = $VBoxContainer/HBoxContainer/SelectBoard

	pmenu.get_popup().connect("id_pressed", self, "_on_SelectPart_pressed")
	bmenu.get_popup().connect("id_pressed", self, "_on_SelectBoard_pressed")


func update_devices(data):
	var pmenuopts = pmenu.get_popup()
	var k = 0
	devices = []
	for part in data:
		var boards = []
		for board in data[part].boards:
			boards.append([board, data[part].boards[board].name])
		var pname = data[part].name
		pmenuopts.add_item(pname, k)
		devices.append({
			'id': part,
			'name': pname,
			'boards': boards
		})
		k += 1
	pmenu.text = 'Part'
	bmenu.text = 'Board'
	bmenu.disabled = true


func _select(
	part=null,
	board=null
):
	if part == null:
		selected_part = null
		pmenu.text = 'Part'
		bmenu.disabled = true
		return
		
	selected_part = part
	pmenu.text = devices[part].name
	bmenu.disabled = false
	var bmenuopts = bmenu.get_popup()
	bmenuopts.clear()
	var k = 0
	for item in devices[part].boards:
		bmenuopts.add_item(devices[part].boards[k][1], k)
		k += 1
	if board == null:
		selected_board = null
		bmenu.text = 'Board'
		return
	selected_board = board
	bmenu.text = devices[part].boards[board][1]
	

func _on_SelectPart_pressed(idx):
	print('Part ', idx)
	_select(idx)


func _on_SelectBoard_pressed(idx):
	print('Board ', idx)
	_select(selected_part, idx)
