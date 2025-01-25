extends Control

func fade_in(title):
	$CenterContainer/VBoxContainer/Label.text = title
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	queue_free()
