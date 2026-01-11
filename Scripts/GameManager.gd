class_name GameManager
extends Node

var Cell = preload("res://Scripts/Cell.gd")
@export var cell:Cell
@export var player_company:Company

var time_before_new_comp: float = 0
var time_for_new_comp: float = 1
var comp = preload("res://Prefabs/component.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	if (time_for_new_comp <= time_before_new_comp):
		var new_comp = comp.instantiate()
		add_child(new_comp)
		new_comp.position = Vector2(148.0,203.0)
		print_debug(new_comp.position)
		time_before_new_comp = 0
	time_before_new_comp += delta

func _on_cell_completed() -> void:
	if cell.is_exploding():
		player_company.set_score(player_company.score - cell.calc_money_reward())
		return
	player_company.set_score(player_company.score + cell.calc_money_reward())
