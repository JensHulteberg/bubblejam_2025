extends Node

var card_res = preload("res://scenes/card.tscn")

var deck: Deck
var hand: CardHand


func _ready():
	set_process_input(true)
	PlayerState.draw_card.connect(draw_full)

	PlayerState.add_card_to_deck.connect(_on_add_card_to_deck)
	#Market.market_update.connect(pull_card)


func _on_add_card_to_deck(card):
	deck.add_card_to_bottom(card)
	deck.shuffle()
	
	

func init(deck_, hand_):
	deck = deck_
	hand = hand_
	hand.card_manager = self
	
	for card_ref in PlayerState.deck:
		for i in range(card_ref.amount):
			var card = card_res.instantiate()
			deck.add_card_to_bottom(card)
			card.init(card_ref.stock)
			card.set_purchase_price(card_ref.buy_price)
			

func save_cards_to_player_state() -> void:
	var ids = deck.cards.map(func(c): return {" id": c.stock_id, "buy_price": c.buy_price })
	ids.append_array(hand.cards.map(func(c): return {"stock_id": c.stock_id, "buy_price": c.buy_price }))
	
	PlayerState.deck = ids.map(func(i_obj): return {"stock": Market.get_aktie_by_id(i_obj.stock_id), "amount": 1, "buy_price": i_obj.buy_price})
	hand

func draw_full():
	for i in range(hand.hand_spots_left()):
		pull_card()

func pull_card():
	if hand.at_limit():
		return
	
	var card = deck.pull_card()
	if card == null:
		return
	
	var z_index_before = card.z_index
	card.offset = 0
	card.global_position = deck.global_position + (deck.size / 2) - (card.size / 2)
	await _to_hand(card)
	if hand == null:
		return
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
