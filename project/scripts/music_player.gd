extends AudioStreamPlayer

var songs = {
	"theme": {
		"song": preload("res://sound/gloomberg.ogg"),
		"loop_offset": 16.0,
	},
	"intro": {
		"song": preload("res://sound/gloomberg_intro.ogg"),
		"loop_offset": 0.0,
	},
	"end": {
		"song": preload("res://sound/gloomberg_end.ogg"),
		"loop_offset": 25.585,
	},
}

var loop_offset = 0.0


func play_song(name: String):
	await fade_out()
	volume_db = 0
	stream = songs[name].song
	loop_offset = songs[name].loop_offset
	play()


func fade_out(duration: float = 1.0):
	if playing:
		var tween = create_tween()
		tween.tween_property(self, "volume_db", -100, duration)
		await tween.finished
		stop()


func _on_finished() -> void:
	play(loop_offset)
