extends GraphNode


class_name GNode


func _ready():
	Utils.checkError(
		connect('resize_request', self, '_on_resize_request'),
		"connecting GNode resize_request"
	);


func _on_resize_request(new_minsize):
	rect_size = new_minsize

