extends Spatial

var library : Array = []; 
var libidx : int = 0;

var defaultInstanceMesh;
var defaultInstanceMaterial : SpatialMaterial;

var addingInstance : bool = false;



func _newCube(inputs, outputs):
	var cube = CubeMesh.new();
	cube.size = Vector3(1, 1, max(inputs, outputs));
	return cube;


func _newSpatialMaterial(rgb):
	var material = SpatialMaterial.new();
	material.albedo_color = Color(rgb[0], rgb[1], rgb[2]);
	return material


func _ready():
	defaultInstanceMesh = $User/Body.get_mesh();
	defaultInstanceMaterial = $User/Body.get_surface_material(0);

	for gate in Data.gates.values():
		if not gate.has("mesh"):
			gate["mesh"] = _newCube(gate["inputs"], gate["outputs"])
		if not gate.has("material"):
			gate["material"] = _newSpatialMaterial(gate["color"])
	
	library = Data.gates.keys();


func _changeInstance(idx):
	var instance;
	if idx >= 0:
		libidx = idx;
		instance = Data.gates[library[libidx]];
		$User/Body/Pointer.hide();
	else:
		$User/Body/Pointer.show();
		instance = {
			"mesh": defaultInstanceMesh,
			"material": defaultInstanceMaterial
		};
	$User/Body.set_mesh(instance["mesh"]);
	$User/Body.set_surface_material(0, instance["material"]);


func _placeInstance():
	print($Blocks.get_children());
	var mesh = MeshInstance.new();
	mesh.set_mesh($User/Body.get_mesh());
	mesh.set_surface_material(0, $User/Body.get_surface_material(0));
	mesh.transform = $User.transform;
	$Blocks.add_child(mesh);


func _unhandled_input(_ev: InputEvent) -> void:
	if addingInstance:
		if Input.is_action_pressed("ui_cancel"):
			addingInstance = false;
			_changeInstance(-1);
		elif Input.is_action_pressed("ui_page_down"):
			_changeInstance(libidx+1 if libidx < library.size()-1 else 0);
		elif Input.is_action_pressed("ui_page_up"):
			_changeInstance(libidx-1 if libidx > 0 else library.size()-1);
		elif Input.is_action_pressed("ui_add_instance"):
			_placeInstance();
	else:
		if Input.is_action_pressed("ui_add_instance"):
			addingInstance = true;
			_changeInstance(libidx);

	if Input.is_action_pressed("ui_up"):
		$User.transform.origin += Vector3(1,0,0);
	elif Input.is_action_pressed("ui_down"):
		$User.transform.origin -= Vector3(1,0,0);
	elif Input.is_action_pressed("ui_left"):
		$User.transform.origin -= Vector3(0,0,1);
	elif Input.is_action_pressed("ui_right"):
		$User.transform.origin += Vector3(0,0,1);
