extends Tabs


onready var prj_tree : Tree = $HSplitContainer/VSplitContainer/Projects;
onready var lib_tree : Tree = $HSplitContainer/VSplitContainer/Libraries;

enum project_buttons {
	ADD
	CHECK
	EDIT
	RELOAD
	REMOVE
}


func _ready():
	_Projects_init_tree();
	_Libraries_init_tree();


func _Projects_init_tree()  -> void:
	var _root = prj_tree.create_item();
	
	prj_tree.columns = 2;
	#prj_tree.set_column_expand(0, true);
	#prj_tree.set_column_min_width(0, 2);

	var entry;

	for prj in Data.projects:
		entry = prj_tree.create_item();
		_Projects_init_Project(entry, prj);

	entry = prj_tree.create_item();
	entry.set_text(0, 'New project');
	entry.set_editable(0, true);
	entry.set_expand_right(0, true);
	entry.add_button(0, Data.icons.plus, project_buttons.ADD, false, 'Add')

	for sig in ['cell_selected', 'nothing_selected', 'item_activated', 'button_pressed', 'item_edited']:
		Utils.checkError(
			prj_tree.connect(sig, self, '_Projects_on_{0}'.format([sig])),
			'connecting Repositories...Projects {0}'.format([sig])
		);


func _Projects_init_Project(
	root : TreeItem,
	prj : Data.Project
) -> void:
	root.set_metadata(0, {"Project": prj});
	root.set_text(0, prj.Name);
	root.set_expand_right(0, true);
	_add_Buttons([
		{
			'text': 'Edit',
			'icon': 'pencil',
			'id': project_buttons.EDIT
		},
		{
			'text': 'Check all',
			'icon': 'check',
			'id': project_buttons.CHECK
		},
		{
			'text': 'Reload all',
			'icon': 'refresh',
			'id': project_buttons.RELOAD
		},
		{
			'text': 'Remove',
			'icon': 'delete',
			'id': project_buttons.REMOVE
		}
	], root, 0);

	var item;
	for src in prj.Sources:
		print('[Repositories] _Projects_init_tree {0} <{1}>'.format([prj, src.Location]));
		_Projects_init_Source(prj_tree.create_item(root), src);

	item = prj_tree.create_item(root);
	item.set_text(0, 'New source location');
	item.set_editable(0, true);
	_add_Range_Cell(Data.Types.source_types_str, item, 1);
	_add_Buttons([
		{
			'text': 'Check',
			'icon': 'check',
			'id': project_buttons.CHECK
		},
		{
			'text': 'Add',
			'icon': 'plus',
			'id': project_buttons.ADD
		}
	], item, 1);


func _Projects_init_Source(
	root : TreeItem,
	src : Data.Source
) -> void:
	root.set_metadata(0, {"Location": src});
	root.set_text(0, src.Location);
	root.add_button(0, Data.icons.pencil, project_buttons.EDIT, false, 'Edit');
	_add_Range_Cell(Data.Types.source_types_str, root, 1, src.Type);
	_add_Buttons([
		{
			'text': 'Check',
			'icon': 'check',
			'id': project_buttons.CHECK
		},
		{
			'text': 'Reload',
			'icon': 'refresh',
			'id': project_buttons.RELOAD
		},
		{
			'text': 'Remove',
			'icon': 'delete',
			'id': project_buttons.REMOVE
		}
	], root, 1);


func _Libraries_init_tree() -> void:
	var _root = lib_tree.create_item();
	
	lib_tree.columns = 1;

	var entry;

	entry = lib_tree.create_item();
	entry.set_text(0, 'lib');


func _add_Buttons(
	btns,
	item : TreeItem,
	column : int = 0
) -> void:
	for btn in btns:
		item.add_button(column, Data.icons[btn.icon], btn.id, false, btn.text);


func _add_Range_Cell(
	opts : String,
	item : TreeItem,
	column : int = 0,
	default : int = 0,
	editable : bool = true
) -> void:
	item.set_cell_mode(column, TreeItem.CELL_MODE_RANGE);
	item.set_editable(column, editable);
	item.set_text(column, opts);
	item.set_range(column, default);


func _Projects_on_cell_selected():
	var item = prj_tree.get_selected();
	var column = prj_tree.get_selected_column();
	var msg = '[Repositories] _Projects_on_cell_selected item {0}'.format([item]);
	if column == 0:
		print('{0} <{1}>'.format([msg, item.get_text(0)]));
		# TODO: implement filtering the content of Libraries and the ItemList panel on the right, according to the
		# selected scope (project or source).
	# For now, ignore selection of other columns.


func _Projects_on_nothing_selected():
	var item = prj_tree.get_selected();
	if item:
		item.deselect(prj_tree.get_selected_column());


func _Projects_on_item_activated():
	var item = prj_tree.get_selected();
	var column = prj_tree.get_selected_column();
	var msg = '[Repositories] _Projects_on_item_activated item {0}'.format([item]);
	# Ignore the last in each section (the one for adding new items).
	if item.get_next() == null:
		return
	if column != 0:
		return
	item.set_editable(column, true);
	print('{0} {1} {2}'.format([
		msg,
		item.get_text(0),
		'Cannot edit selected!' if not prj_tree.edit_selected() else ''
	]));


func _Projects_on_button_pressed(
	item : TreeItem,
	column : int,
	idx : int
):
	var msg = '[Repositories] _Projects_on_button_pressed item {0} column {1} id {2}'.format([item, column, idx]);
	match idx:
		project_buttons.ADD:
			_Projects_find_prj(
				item,
				null,
				funcref(self, "_Projects_add_Source"),
				funcref(self, "_Projects_add_Project"),
				msg
			);

		project_buttons.EDIT:
			item.select(0);
			item.set_editable(0, true);
			prj_tree.call_deferred("edit_selected");

		project_buttons.REMOVE:
			_Projects_find_prj(
				item,
				funcref(self, "_Projects_remove_Project"),
				funcref(self, "_Projects_remove_Source"),
				null,
				msg
			);

		_:
			print('{0} ! unhandled button'.format([msg]));


func _Projects_on_item_edited():
	var item = prj_tree.get_edited();
	var column = prj_tree.get_edited_column();
	var mode = item.get_cell_mode(column);
	var msg = '[Repositories] _Projects_on_item_edited {0} column {1}'.format([item, column]);

	# Ignore the last in each section (the one for adding new items).
	if item.get_next() == null:
		return

	if column == 1 and mode == TreeItem.CELL_MODE_RANGE:
		print('{0} Range Cell {1}'.format([msg, item.get_range(column)]));
		_Projects_set_Source(null, item);
		
	elif column == 0 and mode == TreeItem.CELL_MODE_STRING:
		if item.is_editable(column):
			item.set_editable(column, false);
		msg = '{0} String Cell {1}'.format([msg, item.get_text(column)]);
		_Projects_find_prj(
			item,
			funcref(self, "_Projects_set_Project"),
			funcref(self, "_Projects_set_Source"),
			null,
			msg
		);


func _Projects_find_prj(
	item : TreeItem,
	this_fcn : FuncRef,
	parent_fcn : FuncRef,
	none_fcn : FuncRef,
	msg : String
) -> void:
	var metadata = item.get_metadata(0);
	if metadata and metadata.get("Project"):
		print('{0} : this_fcn'.format([msg]));
		this_fcn.call_func(metadata["Project"], item);
		return
		
	metadata = item.get_parent().get_metadata(0);
	if metadata and metadata.get("Project"):
		print('{0} : parent_fcn'.format([msg]));
		parent_fcn.call_func(metadata["Project"], item);
		return
	
	print('{0} : none_fcn'.format([msg]));
	none_fcn.call_func(item)


func _get_last(item):
	var last;
	var next = item;
	while next != null:
		last = next;
		next = last.get_next();
	return last


func _Projects_set_Project(
	prj : Data.Types.Project,
	item : TreeItem
) -> void:
	var name = item.get_text(0);
	if name != prj.Name:
		prj.Name = name


func _Projects_set_Source(
	_prj : Data.Types.Project,
	item : TreeItem
) -> void:
	var path = item.get_text(0);
	var type = item.get_range(1);
	var src = item.get_metadata(0)["Location"];
	if src.Location != path:
		src.Location = path;
	if src.Type != type:
		src.Type = type;


func _Projects_add_Project(
	item : TreeItem
) -> void:
	var name = item.get_text(0);
	item.set_text(0, 'New project');
	
	var prj = Data.Project.new(name, []);
	Data.projects.append(prj);

	var parent = item.get_parent();
	var last = _get_last(parent.get_children());
	_Projects_init_Project(prj_tree.create_item(parent), prj);
	last.move_to_bottom();


func _Projects_add_Source(
	prj : Data.Types.Project,
	item : TreeItem
) -> void:
	var path = item.get_text(0);
	var type = item.get_range(1);
	item.set_text(0, 'New source location');
	item.set_range(1, Data.Types.source_types.GLOB);
	
	var src = Data.Source.new(path, type);
	prj.Sources.append(src);
	
	var parent = item.get_parent();
	var last = _get_last(parent.get_children());
	_Projects_init_Source(prj_tree.create_item(parent), src);
	last.move_to_bottom();


func _Projects_remove_Project(
	prj : Data.Types.Project,
	item : TreeItem
) -> void:
	prj.free();
	item.free();


func _Projects_remove_Source(
	prj : Data.Types.Project,
	item : TreeItem
) -> void:
	prj.Sources.erase(item.get_metadata(0)["Location"]);
	item.free();
