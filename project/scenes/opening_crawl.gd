extends Control

var start_menu_res = preload("res://scenes/start_menu.tscn")

func _ready() -> void:
	MusicPlayer.play_song("intro")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	instance_start_menu()

func instance_start_menu():
	var start_menu = start_menu_res.instantiate()
	get_parent().add_child(start_menu)
	queue_free()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			instance_start_menu()
