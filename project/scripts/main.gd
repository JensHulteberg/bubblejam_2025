extends Node

var days = ["Day_1"]
var day_index = 1

@onready var bloomberg_terminal: MarginContainer = $CanvasLayer/BloombergTerminal
@onready var card_manager: Control = $CanvasLayer/CardManager

func _ready() -> void:
	$AnimationPlayer.play("day_" + str(day_index))
	$AnimationPlayer.animation_finished.connect(_on_day_over)
	$CanvasLayer/BloombergTerminal.set_timeout(90)

	card_manager.init(bloomberg_terminal.deck, bloomberg_terminal.card_hand)

func publish_news(id):
	Redaktionen.publish_news_item(id)

func _on_day_over(anim_name):
	print("DAY OVER DO STUFF")
