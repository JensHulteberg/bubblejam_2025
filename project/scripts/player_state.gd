extends Node

signal money_updated
signal draw_card
signal add_card_to_market
signal add_card_to_deck

var deck

var draw_card_timer_limit = 3
var card_to_market_timer_limit = 3
var draw_card_timer = 0
var card_market_timer = 0

var money = 0 :
	set(value):
		emit_signal("money_updated", money, value)
		money = value

var day_begin_stats = []
var day_end_stats = []

func _ready() -> void:
	#deck = [
	#{"stock": Market.get_aktie_by_id(1), "amount": 4},
	#{"stock": Market.get_aktie_by_id(2), "amount": 3},
	#{"stock": Market.get_aktie_by_id(3), "amount": 6}
	#]
	deck = []

	money = 1000
	Market.market_update.connect(_on_market_update)

func calc_deck_value() -> int:
	var sum = 0
	for card_ref in PlayerState.deck:
		sum += Market.get_aktie_by_id(card_ref.stock.id).value * card_ref.amount
	return sum

func save_day_begin(id: int) -> void:
	day_begin_stats.append({"day": id,  "money": money, "stocks": calc_deck_value()})

func save_day_end(id: int) -> void:
	day_end_stats.append({"day": id,  "money": money, "stocks": calc_deck_value()})

func get_day_end(id: int) -> Dictionary:
	for stats in day_end_stats:
		if stats.day == id:
			return stats
			
	return {}

func _on_market_update():
	draw_card_timer += 1
	card_market_timer += 1
	if draw_card_timer >= draw_card_timer_limit:
		emit_signal("draw_card")
		draw_card_timer = 0
	
	if card_market_timer >= card_to_market_timer_limit:
		emit_signal("add_card_to_market")
		card_market_timer = 0
