class_name Slot
extends Node2D

var Component = preload("res://Scripts/Component.gd")

@export var component:Component
@export var typeNeeded:Component.Types
@export var orientationNeeded:int
@export var isTrash:bool

signal hover(slot:Slot, is_hovered:bool)
signal added_component

func set_component(component :Component):
	if isTrash:
		component.free_me()
		return true
	
	if has_component():
		return false
	
	if is_component_valid(component):
		self.component = component
		component.set_used()
		component.position = self.global_position
		added_component.emit()
		return true
	
	return false

func is_component_valid(component:Component):
	return component.is_valid(typeNeeded, orientationNeeded)

func has_component():
	return self.component != null

func get_component():
	return self.component

func _on_area_2d_mouse_entered() -> void:
	hover.emit(self, true)

func _on_area_2d_mouse_exited() -> void:
	hover.emit(self, false)
