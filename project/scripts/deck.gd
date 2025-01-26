class_name Deck extends Control

const BACKSIDE_CARD = preload("res://scenes/card_backside.tscn")

var cards: Array[Card]

var backside_cards: Array

func _ready():
	pass
	#var card = preload("res://scenes/card.tscn")
	#for i in range(50):
		#add_card_to_bottom(card.instantiate())


func add_card_to_bottom(card: Card):
	card.visible = false
	cards.append(card)
	if card.get_parent() == null:
		add_child(card)
	else:
		card.reparent(self)
	
	var backside_card = BACKSIDE_CARD.instantiate()
	_add_backside_card.call_deferred(backside_card)


func pull_card() -> Card:
	if cards.size() == 0:
		return
	
	_remove_backside_card()
	var card = cards.pop_front()
	card.anchor_x = 0.5
	card.anchor_y = 0.5
	card.visible = true
	return card


func shuffle():
	cards.shuffle()


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
