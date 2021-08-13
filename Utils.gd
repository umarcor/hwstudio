extends Node


var APIRequest : HTTPRequest = HTTPRequest.new()

const icons = {
	'check': preload('res://img/btn/check.svg'),
	'check-all': preload('res://img/btn/check-all.svg'),
	'copy': preload('res://img/btn/content-copy.svg'),
	'delete': preload('res://img/btn/delete.svg'),
	'eye': preload('res://img/btn/eye.svg'),
	'pencil': preload('res://img/btn/pencil.svg'),
	'plus': preload('res://img/btn/plus-thick.svg'),
	'refresh': preload('res://img/btn/refresh.svg')
};


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
