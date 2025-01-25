extends MarginContainer

var market_max_value = 5

var card_buy_vis_res = preload("res://scenes/card_sell_presenter.tscn")

@onready var stack = $HBoxContainer

func _ready() -> void:
	PlayerState.add_card_to_market.connect(_on_add_card_to_market)
	clear_stack()


func add_card_to_market(stock: Aktie):
	var card_buy_vis = card_buy_vis_res.instantiate()
	
	stack.add_child(card_buy_vis)
	card_buy_vis.init(stock)
	if stack.get_children().size() > market_max_value:
		stack.get_children()[-1].queue_free()
	

func _on_add_card_to_market():
	add_card_to_market(Market.aktier.pick_random())

func clear_stack():
	for child in stack.get_children():
		child.queue_free()
