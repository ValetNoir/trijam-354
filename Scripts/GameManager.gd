class_name GameManager
extends Node2D

var Cell = preload("res://Scripts/Cell.gd")
@export var cell:Cell
@export var player_company:Company

var Slot = preload("res://Scripts/Slot.gd")
var hovered_slot:Slot = null

var Component = preload("res://Scripts/Component.gd")
var time_before_new_comp: float = 0
var time_for_new_comp: float = 1

const prefab_components = [
	preload("res://Prefabs/cap_component.tscn"),
	preload("res://Prefabs/core_component.tscn"),
	preload("res://Prefabs/system_component.tscn"),
	preload("res://Prefabs/bottom_component.tscn"),
	]

@onready var comp_spawner: Node2D = $CompSpawner
var components:Array[Component]
var hovered_comp:Component = null

func _ready() -> void:
	cell.completed.connect(_on_cell_completed)
	cell.slot_hover.connect(_on_cell_slot_hover)

func _on_cell_completed() -> void:
	if cell.is_exploding():
		player_company.set_score(player_company.score - cell.calc_money_reward())
		return
	player_company.set_score(player_company.score + cell.calc_money_reward())

func on_slot_hover(slot:Slot, is_hovered:bool):
	if !is_hovered and hovered_slot == slot:
		hovered_slot = null
	if is_hovered:
		hovered_slot = slot

func _on_cell_slot_hover(slot:Slot, is_hovered:bool):
	on_slot_hover(slot, is_hovered)

func _on_component_hover(component:Component, is_hovered:bool):
	if hovered_comp != null and hovered_comp.is_dragged:
		return
	
	if !is_hovered and hovered_comp == component:
		hovered_comp = null
	if is_hovered:
		hovered_comp = component

func _on_component_drag(component:Component, is_drop:bool):
	if component != hovered_comp:
		return
	if !is_drop:
		component.is_dragged = true
		return
	if is_drop:
		if hovered_slot != null:
			if !hovered_slot.set_component(hovered_comp):
				return
		component.is_dragged = false
		return

func _on_component_freeing(component:Component):
	components.erase(component)
	component.hover.disconnect(_on_component_hover)
	component.drag.disconnect(_on_component_drag)
	component.freeing.disconnect(_on_component_freeing)
	component.queue_free()

func _on_timer_timeout() -> void:
	var obj_comp = prefab_components.pick_random().instantiate()
	add_child(obj_comp)
	obj_comp.position = comp_spawner.position
	var component = obj_comp as Component
	component.hover.connect(_on_component_hover)
	component.drag.connect(_on_component_drag)
	component.freeing.connect(_on_component_freeing)
	components.append(component)

func _on_trash_hover(slot: Slot, is_hovered: bool) -> void:
	on_slot_hover(slot, is_hovered)

func _on_conveyor_area_entered(area: Area2D) -> void:
	for component:Component in components:
		component.conveyor_enter(area)

func _on_conveyor_area_exited(area: Area2D) -> void:
	for component:Component in components:
		component.conveyor_exit(area)

func _on_void_area_entered(area: Area2D) -> void:
	for component:Component in components:
		component.void_enter(area)
