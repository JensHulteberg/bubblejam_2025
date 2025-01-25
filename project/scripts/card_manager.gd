extends Node


var deck: Deck
var hand: CardHand


func _ready():
	set_process_input(true)


func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		pull_card()


func pull_card():
	if hand.at_limit():
		return
	
	var card = deck.pull_card()
	
	card.reparent(self)
	var z_index_before = card.z_index
	card.z_index = 500
	card.offset = 0
	card.global_position = deck.global_position + (deck.size / 2) - (card.size / 2)
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	var duration = 0.3
	tween.tween_property(
		card,
		"global_position",
		hand.global_position + (hand.size / 2) - (card.size / 2),
		duration,
	)
	
	await tween.finished
	
	hand.add_card(card)
	await hand.visualize()
	card.z_index = z_index_before
	
