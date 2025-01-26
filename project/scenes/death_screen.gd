extends Control

var max_loops = 6
var loop_count = 0

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_anim_finished)
	$AnimationPlayer.play("death_anim_2")
	SfxPlayer.play_sfx("cluster")
	MusicPlayer.stop()
	

func _on_anim_finished(anim_name):
	loop_count += 1
	if loop_count > max_loops - 2:
		$CenterContainer/RichTextLabel.text = "YOU BLOW YOUR BRAINS OUT..."
	if loop_count > max_loops:
		pass
		#visible = false
		
		return
	if loop_count > max_loops - 1:
		$Timer.start()
	$AnimationPlayer.play("death_anim_2")
	SfxPlayer.play_sfx("cluster")

func play_end_music():
	MusicPlayer.play_song("end")

func _on_timer_timeout() -> void:
	SfxPlayer.play_sfx("gunshot")
	$logo_wait_timer.start(0.6)
	await $logo_wait_timer.timeout
	$AnimationPlayer.play("fade_in_logo")
	
	#get_tree().quit()
	
