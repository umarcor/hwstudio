extends AcceptDialog


var tree 

var tabs

func _ready():
	#$VSplitContainer/Details.visible = false
		
	tabs = $VSplitContainer/TabContainer
		
	var utils = {
		'Constant': null,
		'Label': null,
		'Slice': null,
		'Gates': {
			'AND': null,
			'OR': null,
			'XOR': null,
			'NOT': null,
			'NAND': null,
			'NOR': null,
			'XNOR': null
		},
		'Combinatorial': {
			'CMP': null,
			'MUX': null,
			'DEMUX': null,
			'ENC': null,
			'DEC': null
		}
	}

	_add_tab('Utils', utils)

	tabs.current_tab = 1
	
	
func _add_tab(name, items):
	print('Adding tab...')
	var tree = Tree.new()
	
	tree.name = name
	var root = tree.create_item()
	tree.set_hide_root(true)
	for item in items:
		var entry = tree.create_item(root)
		entry.set_text(0, item)
		if items[item]:
			var clist = items[item]
			for child in clist:
				var centry = tree.create_item(entry)
				centry.set_text(0, child)
	tabs.add_child(tree)
