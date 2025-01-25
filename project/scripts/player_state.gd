extends Node

signal money_updated
signal draw_card
signal add_card_to_market

var deck

var draw_card_timer_limit = 1
var card_to_market_timer_limit = 10
var draw_card_timer = 0
var card_market_timer = 0


var money = 0 :
	set(value):
		emit_signal("money_updated", money, value)
		money = value

func _ready() -> void:
	deck = [
	{"stock": Market.get_aktie_by_id(1), "amount": 4},
	{"stock": Market.get_aktie_by_id(2), "amount": 3},
	{"stock": Market.get_aktie_by_id(3), "amount": 6}
	]

	
	Market.market_update.connect(_on_market_update)

func _on_market_update():
	draw_card_timer += 1
	card_market_timer += 1
	if draw_card_timer >= draw_card_timer_limit:
		emit_signal("draw_card")
		draw_card_timer = 0
	
	if card_market_timer >= card_to_market_timer_limit:
		emit_signal("add_card_to_market")
		card_market_timer = 0
