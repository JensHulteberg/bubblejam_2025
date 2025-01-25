extends Control

const BACKSIDE_CARD = preload("res://scenes/card_backside.tscn")

var cards: Array[Card]

var backside_cards: Array

func _ready():
	var card = preload("res://scenes/card.tscn")
	for i in range(50):
		add_card_to_bottom(card.instantiate())


func add_card_to_bottom(card: Card):
	card.visible = false
	cards.append(card)
	
	var backside_card = BACKSIDE_CARD.instantiate()
	_add_backside_card.call_deferred(backside_card)


func pull_card() -> Card:
	_remove_backside_card()
	return cards.pop_front()


func shuffle():
	var rand_sort = func(a, b):
		return randi() % 2 == 1
	cards.sort_custom(rand_sort)


func _add_backside_card(backside_card):
	add_child(backside_card)
	backside_cards.append(backside_card)
	var index = backside_cards.size() - 1
	
	var x = 0.5 - 0.001 * index
	var y = 0.5 - 0.001 * index
	backside_card.anchor_left = x
	backside_card.anchor_right = x
	backside_card.anchor_top = y
	backside_card.anchor_bottom = y
	
	backside_card.z_index = -index


func _remove_backside_card():
	remove_child(backside_cards.pop_back())
