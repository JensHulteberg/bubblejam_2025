extends AudioStreamPlayer

var songs = {
	"theme": preload("res://sound/gloomberg.ogg"),
	"intro": preload("res://sound/gloomberg_intro.ogg"),
}

func _ready() -> void:
	pass
	#play_song("intro")


func play_song(name: String):
	await fade_out()
	volume_db = 0
	stream = songs[name]
	play()


func fade_out(duration: float = 1.0):
	if playing:
		var tween = create_tween()
		tween.tween_property(self, "volume_db", -100, duration)
		await tween.finished
		stop()
	
