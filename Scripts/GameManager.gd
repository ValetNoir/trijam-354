class_name GameManager
extends Node

var Cell = preload("res://Scripts/Cell.gd")
@export var cell:Cell
@export var player_company:Company

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	pass

func _on_cell_completed() -> void:
	if cell.is_exploding():
		player_company.set_score(player_company.score - cell.calc_money_reward())
		return
	player_company.set_score(player_company.score + cell.calc_money_reward())
