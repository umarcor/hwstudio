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
		},
		'Sequential': {
			'Counters': {
				'Up': null,
				'Down': null,
				'UpDown': null
			}
		}
	}

	_add_tab('Utils', utils)

	tabs.current_tab = 1
	
	
func _add_buttons_to_treeitem(item):
	item.add_button(0, preload("res://img/btn/plus-thick.svg"), 0, false, "Add instance")
	item.add_button(0, preload("res://img/btn/eye.svg"), 1, false, "View in editor")
	item.add_button(0, preload("res://img/btn/pencil.svg"), 2, false, "Edit")
	item.add_button(0, preload("res://img/btn/content-copy.svg"), 3, false, "Create a copy")
	
	
func _add_children_recursively(tree, entry, children):
	if children:
		for child in children:
			var centry = tree.create_item(entry)
			centry.set_text(0, child)
			_add_children_recursively(tree, centry, children[child])
	else:
		_add_buttons_to_treeitem(entry)
	
	
# NOTE: to be read carefully https://www.reddit.com/r/godot/comments/gtw71z/how_do_i_use_this_tree_control_node/
	
func _add_tab(name, items):
	print('Adding tab...')
	var tree = Tree.new()
	tree.name = name
	tree.columns = 1
	var root = tree.create_item()
	tree.set_hide_root(true)
	for item in items:
		var entry = tree.create_item(root)
		entry.set_text(0, item)
		_add_children_recursively(tree, entry, items[item])
	tabs.add_child(tree)
	tree.connect('button_pressed', self, '_tree_button_pressed')


func _tree_button_pressed(item, column, id):
	print('Tree button pressed ', item.get_text(0), ' column ', column, ' id ', id)
	
