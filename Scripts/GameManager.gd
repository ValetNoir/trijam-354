class_name GameManager
extends Node

var Cell = preload("res://Scripts/Cell.gd")
@export var cell :Cell

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cell.is_completed():
		pass # send battery to prod
