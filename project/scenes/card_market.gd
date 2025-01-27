extends Panel

var market_max_value = 5

var card_buy_vis_res = preload("res://scenes/card_sell_presenter.tscn")

@onready var stack = $MarginContainer/HBoxContainer
@onready var timer_bar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	PlayerState.add_card_to_market.connect(_on_add_card_to_market)
	_on_add_card_to_market()
	timer_bar.max_value = PlayerState.card_to_market_timer_limit * Market.stock_update_delay
	$Timer.start(PlayerState.card_to_market_timer_limit * Market.stock_update_delay)


func add_card_to_market(stock: Aktie):

	var card_buy_vis = card_buy_vis_res.instantiate()
	
	stack.add_child(card_buy_vis)
	
	card_buy_vis.init(stock)
	
	stack.move_child(card_buy_vis, 0)
	
	#if stack.get_children().size() > market_max_value:
		#stack.get_children()[-1].free()

func _process(delta: float) -> void:
	timer_bar.value = $Timer.time_left

func _on_add_card_to_market():
	timer_bar.value = timer_bar.max_value
	$Timer.start(timer_bar.max_value)
	$AnimationPlayer.play("refresh_blink")
	clear_stack()
	for i in range(market_max_value):
		add_card_to_market(Market.aktier.pick_random())

func clear_stack():
	for child in stack.get_children():
		child.queue_free()
