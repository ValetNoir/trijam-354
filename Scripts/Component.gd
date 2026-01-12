class_name Component
extends Node2D

enum Types {Cap, System, Core, Bottom}

@export var type:Types
@export var orientation:int

@export var explosion_risk:int
@export var money_reward:int

var is_dragged:bool = false
var is_used:bool = false

var rng = RandomNumberGenerator.new()

signal hover(component:Component, is_hovered:bool)
signal drag(component:Component, is_drop:bool)

func _ready() -> void:
	type = randi_range(0, Types.size() - 1)
	orientation = randi_range(0, 3)
	update_type()
	update_rotation()

func update_type():
	pass #updating sprite

func update_rotation():
	self.rotation_degrees = orientation * 90

func rotate_orientation():
	orientation = (orientation+1) % 4
	update_rotation()

func is_valid(type:Types, orientation:int):
	return type == self.type && orientation == self.orientation

func set_used():
	is_used = true

func _input(event) :
	if is_used:
		return
	if event is InputEventMouseMotion:
		move(event)
	if event is InputEventMouseButton:
		mouse_button(event)

func move(event):
	if is_dragged:
		self.position = event.position

func mouse_button(event):
	if !event.pressed:
		return
	
	if event.button_index == 1:
		if !is_dragged:
			drag.emit(self, false)
			return
		if is_dragged:
			drag.emit(self, true)
			return
	if event.button_index == 2:
		if is_dragged:
			rotate_orientation()

func _on_area_2d_mouse_entered() -> void:
	hover.emit(self, true)

func _on_area_2d_mouse_exited() -> void:
	hover.emit(self, false)
