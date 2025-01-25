extends AudioStreamPlayer

var songs = {
	"theme": preload("res://sound/gloomberg.ogg"),
	"intro": preload("res://sound/gloomberg_intro.ogg"),
}

func _ready() -> void:
	pass
	#play_song("intro")


func play_song(name: String):
	if playing:
		var tween = create_tween()
		tween.tween_property(self, "volume_db", -100, 1)
		await tween.finished
		stop()
	volume_db = 0
	stream = songs[name]
	play()
