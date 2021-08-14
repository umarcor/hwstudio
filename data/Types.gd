#
# Project
#

class Project extends Object:

	var Name : String;
	var Sources : Array;

	func _init(
		name : String,
		sources : Array
	):
		Name = name
		Sources = sources

#
# Source
#

enum source_types {
	GLOB
	PYCAPI
	FUSESOC
}

const source_types_str = 'glob,pyCAPI,FuseSoC';

class Source extends Object:
	var Location : String;
	var Type : int;
	#var entities
	#var architectures

	func _init(
		path : String,
		type : int
	):
		Location = path;
		Type = type;

#
# Design
#

class Design extends Object:
	var Name : String

#
# Target
#

class Target extends Object:
	var Board : String
	
#
# Entity
#

class Entity extends Object:

	#var name
	var Context
	var Generics
	var Ports
	var Types

#
# Architecture
#

class Architecture extends Object:

	#var name
	var Entity
	var Type
