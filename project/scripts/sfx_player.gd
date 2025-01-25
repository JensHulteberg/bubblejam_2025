extends Node

@onready var sound_effects = {
	"disappoint": preload("res://sound/disappoint.ogg"),
	"got_it": preload("res://sound/got-it.ogg"),
	"menacing": preload("res://sound/menacing.ogg"),
	"negative": preload("res://sound/negative.ogg"),
	"piano_jingle": preload("res://sound/piano-jingle.ogg"),
	"positive": preload("res://sound/positive.ogg"),
	"positronic": preload("res://sound/positronic.ogg"),
	"scream": preload("res://sound/scream.ogg"),
	"synth_jingle": preload("res://sound/synth-jingle.ogg"),
	"yeah": preload("res://sound/yeah.ogg"),
	"gunshot": preload("res://sound/gunshot.ogg"),
	"oh_no": preload("res://sound/oh_no.ogg"),
}

func play_sfx(name: String):
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = sound_effects[name]
	audio_stream_player.play()
	await audio_stream_player.finished
	audio_stream_player.queue_free()
