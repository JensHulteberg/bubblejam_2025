extends Node

var days = ["Day_1"]
var day_index = 1

var scene = preload("res://scenes/bloomberg_terminal.tscn")
var bloomberg_terminal: MarginContainer 
@onready var card_manager: Control = $CanvasLayer/CardManager

var day_length: int = 5
var tick: int = 0

func _ready() -> void:
	init_terminal()
	Market.market_update.connect(_on_market_update)
	PlayerState.explode_particles.connect(_explode_particles)


func init_terminal() -> void:
	bloomberg_terminal = scene.instantiate()
	$CanvasLayer.add_child(bloomberg_terminal)
	bloomberg_terminal.set_timeout(day_length)

	card_manager.init(bloomberg_terminal.deck, bloomberg_terminal.card_hand)
	Market.start_day()

func publish_news(id):
	Redaktionen.publish_news_item(id)
	
func _on_market_update() -> void:
	tick += 1
	if tick >= day_length:
		tick = 0
		_on_day_over("")

func _on_day_over(anim_name):
	print("DAY OVER DO STUFF")
	Market.end_day()
	card_manager.save_cards_to_player_state()
	bloomberg_terminal.queue_free()
	
	print("NEW SCENE")
	day_length = 10
	init_terminal()

func _explode_particles():
	$background_particles/GPUParticles2D.emitting = true
