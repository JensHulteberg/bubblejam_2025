extends MarginContainer

var card_res = preload("res://scenes/card.tscn")
@onready var card_on_sale = $VBoxContainer/Card

func _ready() -> void:
	card_on_sale.free()

func init(stock):
	var card = card_res.instantiate()
	
	$VBoxContainer.add_child(card)
	$VBoxContainer.move_child(card, 0)
	 
	card.init(stock)
	card_on_sale = card
	
	


func _on_button_button_down() -> void:
	var can_buy = Market.buy_stock(card_on_sale.stock_id)
	if can_buy:
		SfxPlayer.play_sfx("positive")
		PlayerState.emit_signal("add_card_to_deck", card_on_sale)
		queue_free()


func _on_button_mouse_entered() -> void:
	SfxPlayer.play_sfx("woosh", 0.75 + (randf() / 2), -8.0)
