extends Node


var deck: Deck
var hand: CardHand


func _ready():
	set_process_input(true)


func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		pull_card()


func init(deck_, hand_):
	deck = deck_
	hand = hand_
	hand.card_manager = self

func pull_card():
	if hand.at_limit():
		return
	
	var card = deck.pull_card()
	
	var z_index_before = card.z_index
	card.reparent(self)
	card.offset = 0
	card.global_position = deck.global_position + (deck.size / 2) - (card.size / 2)
	await _to_hand(card)
	hand.add_card(card)
	await hand.visualize()
	card.z_index = z_index_before


func back_to_hand(card: Card):
	var z_index_before = card.z_index
	await _to_hand(card)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	var duration = 0.1
	tween.tween_property(card, "offset_left", 0, duration)
	tween.parallel().tween_property(card, "offset_right", 0, duration)
	tween.parallel().tween_property(card, "offset_top", 0, duration)
	tween.parallel().tween_property(card, "offset_bottom", 0, duration)
	await tween.finished
	await hand.visualize()
	card.z_index = z_index_before


func _to_hand(card):
	card.z_index = 500
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	var duration = 0.3
	tween.tween_property(
		card,
		"global_position",
		hand.global_position + (hand.size / 2) - (card.size / 2),
		duration,
	)
	await tween.finished
