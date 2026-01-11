class_name Slot
extends Node

var Component = preload("res://Scripts/Component.gd")

@export var component :Component

@export var typeNeeded :Component.Types
@export var orientationNeeded :int

@export var isTrash :bool

func set_component(component :Component):
	if isTrash:
		component.queue_free()
		return
	
	if component.is_valid(typeNeeded, orientationNeeded):
		self.component = component

func has_component():
	return self.component != null

func get_component():
	return self.component
