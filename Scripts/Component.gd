class_name Component
extends Node2D

enum Types {COMP_1, COMP_2, COMP_3}

@export var type:Types
@export var orientation:int

@export var explosion_risk:int
@export var money_reward:int

var is_put :bool = false
var is_dragged:bool = false

func is_valid(type:Types, orientation:int):
	return type == self.type && orientation == self.orientation

func _process(delta: float) :
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && $Sprite2D.get_rect().has_point(to_local(get_global_mouse_position())) && !is_put:
		is_dragged = true
	if is_dragged:
		position = get_global_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && is_dragged: #&& Detect If Slot/Trash
		#Launch set_component from slot program
		is_dragged = false
		is_put = true
	pass
