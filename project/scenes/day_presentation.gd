extends Control

func fade_in(title, licence_fee):
	$CenterContainer/VBoxContainer/HBoxContainer/licence.text = licence_fee
	$CenterContainer/VBoxContainer/HBoxContainer/day_label.text = title
	SfxPlayer.play_sfx("big_ben")
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	queue_free()
