extends GraphNode


class_name GNode


func _checkError(err, msg):
	if err != OK:
		print("Failure ", msg, "! ", err);


func _ready():
	_checkError(
		connect('resize_request', self, '_on_resize_request'),
		"connecting GNode resize_request"
	);


func _on_resize_request(new_minsize):
	rect_size = new_minsize

