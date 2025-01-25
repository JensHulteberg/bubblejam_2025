class_name CardHand extends Control

const MAX_NUM_CARDS: int = 7
const MAX_ROT: float = 5.0
const MAX_X_OFFSET: float = 0.4
const MAX_Y_OFFSET: float = 0.05

var cards: Array[Card]

var card_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var example_card = preload("res://scenes/card.tscn")
	#add_card(example_card.instantiate(), true)
	#add_card(example_card.instantiate(), true)
	#add_card(example_card.instantiate(), true)
	#add_card(example_card.instantiate(), true)
	
	visualize()


func add_card(card: Card, initial: bool = false):
	if cards.size() == MAX_NUM_CARDS:
		return false
	
	card.back_to_hand.connect(back_to_hand.bind(card))
	card.card_sold.connect(card_sold.bind(card))

	cards.append(card)
	if card.get_parent() == null:
		add_child(card)
	else:
		card.reparent(self)
	
	if initial:
		card.rotation_degrees = 0
		card.anchor_x = 0.5
		card.anchor_y = 0.5
	
	return true


func back_to_hand(card: Card):
	card_manager.back_to_hand(card)

func card_sold(card: Card):
	cards.remove_at(cards.find(card))
	card.queue_free()

func hand_spots_left() -> int:
	return MAX_NUM_CARDS - cards.size()
	
func at_limit():
	return cards.size() == MAX_NUM_CARDS

func visualize():
	var signals = []
	for index in range(cards.size()):
		var card = cards[index]
		var finished_signal = _visualize_card(index, card)
		signals.append(finished_signal)
	await Util.await_signals(signals)


func _visualize_card(index: int, card: Card):
	#print("Hej")
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
	
	return tween.finished
