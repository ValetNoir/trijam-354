class_name Component
extends Node2D

enum Types {Cap, System, Core, Bottom}

@export var type:Types
@export var orientation:int

@export var explosion_risk:int
@export var money_reward:int

var is_dragged:bool = false
var slotDrop:Slot
var is_on_slot:bool = false
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	type = randi_range(0, Types.size() - 1)

func is_valid(type:Types, orientation:int):
	return type == self.type && orientation == self.orientation

func _process(delta: float) :
	if Input.is_action_just_pressed("LeftClick") && $Sprite2D.get_rect().has_point(to_local(get_global_mouse_position())):
		is_dragged = true
	if is_dragged:
		position = get_global_mouse_position()
		if Input.is_action_just_pressed("RightClick"):
			_rotation()
		if Input.is_action_just_pressed("LeftClick") && is_on_slot:
			slotDrop.set_component(self)

func _rotation():
	if self.rotation_degrees >= 360.0:
		self.rotation_degrees = 0.0
	self.rotation_degrees += 90.0
	orientation = self.rotation_degrees/90
	
