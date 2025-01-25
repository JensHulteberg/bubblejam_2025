extends Control

const MAX_NUM_CARDS: int = 7
const MAX_ROT: float = 5.0
const MAX_X_OFFSET: float = 0.5
const MAX_Y_OFFSET: float = 0.05

var cards: Array[Card]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var example_card = preload("res://scenes/card.tscn")
	add_card(example_card.instantiate())
	add_card(example_card.instantiate())
	add_card(example_card.instantiate())
	add_card(example_card.instantiate())
	
	visualize()


func add_card(card: Card):
	if cards.size() == MAX_NUM_CARDS:
		return false
	
	card.rotation_degrees = 0
	card.anchor_left = 0.5
	card.anchor_right = 0.5
	card.anchor_top = 0.5
	card.anchor_bottom = 0.5
	
	cards.append(card)
	add_child(card)
	
	return true


func visualize():
	for index in range(cards.size()):
		var card = cards[index]
		_visualize_card(index, card)


func _visualize_card(index: int, card: Card):
	var mid_point = (cards.size() - 1) / 2.0
	var index_offset = mid_point - index
	var offset_float = index_offset / ((MAX_NUM_CARDS - 1) / 2.0)
	
	var rot = MAX_ROT * offset_float
	
	var x = 0.5 + offset_float * MAX_X_OFFSET
	var y = 0.5 + abs(offset_float) * MAX_Y_OFFSET
	
	var duration = 0.2
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(card, "rotation_degrees", rot, duration)
	tween.tween_property(card, "anchor_x", x, duration)
	tween.tween_property(card, "anchor_y", y, duration)
