extends MarginContainer

var card_res = preload("res://scenes/card.tscn")
@onready var stack = $HBoxContainer

func _ready() -> void:
	PlayerState.add_card_to_market.connect(_on_add_card_to_market)


func add_card_to_market(stock: Aktie):
	var card = card_res.instantiate()
	card.init(stock)
	stack.add_child(card)

func _on_add_card_to_market():
	add_card_to_market(Market.aktier.pick_random())

func clear_stack():
	for child in stack.get_children():
		child.queue_free()
