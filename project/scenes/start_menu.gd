extends Control

signal start_game

func _on_enter_button_down() -> void:
	emit_signal("start_game")


func _on_credits_button_down() -> void:
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
