extends Control

const MAX_NUM_CARDS: int = 7
const MAX_ROT: float = 20.0
const MAX_X_OFFSET: float = 0.4
const MAX_Y_OFFSET: float = 0.1

var cards: Array[Card]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var example_card = preload("res://scenes/card.tscn")
	add_card(example_card.instantiate())
	add_card(example_card.instantiate())
	add_card(example_card.instantiate())


func add_card(card: Card):
	if cards.size() == MAX_NUM_CARDS:
		return false
	
	cards.append(card)
	add_child(card)
	visualize()


func visualize():
	for index in range(cards.size()):
		var card = cards[index]
		_visualize_card(index, card)


func _visualize_card(index: int, card: Card):
	var mid_point = (cards.size() - 1) / 2.0
	var index_offset = mid_point - index
	var offset_float = index_offset / (MAX_NUM_CARDS / 2.0)
	
	var rot = MAX_ROT * offset_float
	card.rotation_degrees = rot
	
	var x = 0.5 + offset_float * MAX_X_OFFSET
	var y = 0.5 + abs(offset_float) * MAX_Y_OFFSET
	card.anchor_left = x
	card.anchor_right = x
	card.anchor_top = y
	card.anchor_bottom = y
