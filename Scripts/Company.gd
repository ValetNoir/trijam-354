class_name Company
extends Node2D

@export var timer:Timer
@export var label:Label
@export var is_player:bool
@export var company_name:String

@export var rand_speed_min:int
@export var rand_speed_max:int
@export var rand_score_min:int
@export var rand_score_max:int

var score:int

func _ready() -> void:
	update_label()
	if !is_player:
		run_timer()

func update_label():
	label.text = "%s: %d" % [company_name,score]

func run_timer():
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	timer.wait_time = rng.randi_range(rand_speed_min,rand_speed_max)
	timer.start()

func _on_timer_timeout() -> void:
	var rng:RandomNumberGenerator = RandomNumberGenerator.new()
	set_score(self.score + rng.randi_range(rand_score_min, rand_score_max))
	run_timer()

func set_score(score:int):
	self.score = score
	update_label()
