class_name Cell
extends Node

var Slot = preload("res://Scripts/Slot.gd")

@export var slots:Array[Slot]

func is_completed():
	for slot in slots:
		if !slot.has_component():
			return false
	return true

func is_exploding():
	var explosion_risk:int = 0
	
	for slot in slots:
		explosion_risk += slot.get_component().explosion_risk
	
	explosion_risk = explosion_risk / slots.size()
	
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	var exploding:bool = rng.randi_range(0, 100) < explosion_risk
	
	return exploding

func calc_money_reward():
	var money_reward:int = 0
	
	for slot in slots:
		money_reward += slot.get_component().money_reward
	
	return money_reward
