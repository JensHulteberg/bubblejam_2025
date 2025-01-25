extends Control

func fade_in(title, licence_fee):
	$CenterContainer/VBoxContainer/Label.text = title
	$CenterContainer/VBoxContainer/licence.text = licence_fee
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	queue_free()
