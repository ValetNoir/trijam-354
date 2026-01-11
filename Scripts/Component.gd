class_name Component
extends Node

enum Types {COMP_1, COMP_2, COMP_3}

@export var type :Types
@export var orientation :int

@export var explosion_risk :int
@export var money_reward :int

func is_valid(type :Types, orientation :int):
	return type == self.type && orientation == self.orientation
