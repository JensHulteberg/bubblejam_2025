extends Node

var days = ["Day_1"]
var day_index = 0

var bt = preload("res://scenes/bloomberg_terminal.tscn")
var day_begin = preload("res://scenes/day_presentation.tscn")
var day_end = preload("res://scenes/day_roundup.tscn")

var bloomberg_terminal: MarginContainer 
@onready var card_manager: Control = $CanvasLayer/CardManager

var day_length: int = 10
var tick: int = 0

func _ready() -> void:
	Market.market_update.connect(_on_market_update)
	PlayerState.explode_particles.connect(_explode_particles)
	begin_day()


func begin_day() -> void:
	day_index += 1
	PlayerState.save_day_begin(day_index)
	var day = day_begin.instantiate()
	$CanvasLayer.add_child(day)
	await day.fade_in("MARKET OPENING DAY %s" % day_index, "TERMINAL LICENSE FEE: ₭ %s" % PlayerState.license_fee(day_index))
	init_terminal()
	await day.fade_out()

func init_terminal() -> void:
	bloomberg_terminal = bt.instantiate()
	$CanvasLayer.add_child(bloomberg_terminal)
	bloomberg_terminal.set_timeout(day_length)
	bloomberg_terminal.set_date(date(day_index))
	
	card_manager.init(bloomberg_terminal.deck, bloomberg_terminal.card_hand)
	Market.start_day()
	
	
func date(day: int) -> String:
	return "%s DEC 2057" % (day + 6)

func publish_news(id):
	Redaktionen.publish_news_item(id)
	
func _on_market_update() -> void:
	tick += 1
	if tick >= day_length:
		tick = 0
		_on_day_over("")

func _on_day_over(anim_name):
	Market.end_day()
	card_manager.save_cards_to_player_state()
	PlayerState.save_day_end(day_index)
	Redaktionen.reset()
	
	bloomberg_terminal.queue_free()

	var day_end_stats = PlayerState.get_day_end(day_index)
	
	var day = day_end.instantiate()
	$CanvasLayer.add_child(day)
	day.init(day_index, day_end_stats.money, day_end_stats.stocks, day_end_stats.terminal_fee)
	await day.fade_in()
	
	if day_end_stats.money - day_end_stats.terminal_fee < 0:
		await day.fail_to_pay()
		await day.fade_out()
	else:
		PlayerState.money -= day_end_stats.terminal_fee
		await day.fade_out()
		begin_day()


func _explode_particles():
	$background_particles/GPUParticles2D.emitting = true
