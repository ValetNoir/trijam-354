class_name GameManager
extends Node

var Cell = preload("res://Scripts/Cell.gd")
@export var cell:Cell
@export var player_company:Company

var money:int
var cellsungScore:int
var mokillScore:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float) -> void:
	if cell.is_completed():
		pass # send battery to prod
