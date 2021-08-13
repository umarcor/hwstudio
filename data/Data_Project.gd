extends Object

class_name Project

var Name : String;
var Sources : Array;

enum source_types {
	GLOB
	PYCAPI
	FUSESOC
}
const source_types_str = 'glob,pyCAPI,FuseSoC';

class Source:
	var Location : String;
	var Type : int;

	func _init(
		path : String,
		type : int
	):
		Location = path;
		Type = type;


func _init(
	name : String,
	sources : Array
):
	Name = name
	Sources = sources
