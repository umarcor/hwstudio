extends Node


var APIRequest : HTTPRequest = HTTPRequest.new()


func checkError(
	err : int,
	msg : String
) -> void:
	if err != OK:
		print('Failure {0 ! {1}}'.format([msg,err]));


func _init():
	APIRequest.pause_mode = PAUSE_MODE_PROCESS;
	call_deferred('_add_api_request');


func _add_api_request():
	get_node('/root/Main').add_child(APIRequest);
