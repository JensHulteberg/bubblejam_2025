extends Node

var days = ["Day_1"]
var day_index = 1

func _ready() -> void:
	$AnimationPlayer.play("day_" + str(day_index))
	$AnimationPlayer.animation_finished.connect(_on_day_over)
	$CanvasLayer/BloombergTerminal.set_timeout(90)

func _on_day_over(anim_name):
	get_tree().quit()
