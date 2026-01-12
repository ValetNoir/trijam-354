class_name Component
extends Node2D

enum Types {Cap, System, Core, Bottom}

@export var type:Types
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var orientation:int

@export var explosion_risk:int
@export var money_reward:int

var conveyor_speed:int = 1000

var is_dragged:bool = false
var is_used:bool = false

var is_belted:bool
@onready var area_2d: Area2D = $Area2D

signal hover(component:Component, is_hovered:bool)
signal drag(component:Component, is_drop:bool)
signal freeing(component:Component)

func _ready() -> void:
	orientation = randi_range(0, 3)
	update_rotation()

func _process(delta: float) -> void:
	if is_belted and !is_dragged:
		self.translate(Vector2(conveyor_speed,0) * delta)

func update_rotation():
	self.rotation = orientation * PI/2

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

func conveyor_enter(area:Area2D):
	if area == area_2d:
		is_belted = true

func conveyor_exit(area:Area2D):
	if area == area_2d:
		is_belted = false

func void_enter(area:Area2D):
	if area == area_2d:
		free_me()

func free_me():
	freeing.emit(self)

func _on_area_2d_mouse_entered() -> void:
	hover.emit(self, true)

func _on_area_2d_mouse_exited() -> void:
	hover.emit(self, false)
