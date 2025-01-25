extends Control

var max_loops = 6
var loop_count = 0

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_anim_finished)
	$AnimationPlayer.play("death_anim")
	

func _on_anim_finished(anim_name):
	loop_count += 1
	#if loop_count > max_loops - 2:
		#$CenterContainer/RichTextLabel.text = "YOU BLOW YOUR BRAINS OUT..."
	if loop_count > max_loops:
		visible = false
		SfxPlayer.play_sfx("oh_no")
		return
	if loop_count > max_loops - 1:
		$Timer.start()
	$AnimationPlayer.play("death_anim")


func _on_timer_timeout() -> void:
	#SfxPlayer.play_sfx("gunshot")
	$Timer.start(3)
	await $Timer.timeout
	get_tree().quit()
