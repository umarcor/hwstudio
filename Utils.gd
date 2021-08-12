extends Node


func _checkError(
	err : int,
	msg : String
) -> void:
	if err != OK:
		print("Failure {0 ! {1}}".format([msg,err]));
