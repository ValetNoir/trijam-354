class_name Slot
extends Node

var Component = preload("res://Scripts/Component.gd")

@export var component:Component
@export var typeNeeded:Component.Types
@export var orientationNeeded:int
@export var isTrash:bool

signal added_component

func set_component(component :Component):
	if isTrash:
		component.queue_free()
		return
	
	if component.is_valid(typeNeeded, orientationNeeded):
		self.component = component
	
	added_component.emit()

func has_component():
	return self.component != null

func get_component():
	return self.component

func _on_area_entered(area):
	var component = area.get_parent()
	if component is Component:
		component.is_on_slot = true
		component.slotDrop = self

func _on_area_exit(area):
	var component = area.get_parent()
	if component is Component:
		component.is_on_slot = false
		component.slotDrop = null
	pass
