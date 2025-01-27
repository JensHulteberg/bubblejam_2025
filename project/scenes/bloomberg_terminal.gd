extends MarginContainer

var stock_vis_res = preload("res://scenes/stock.tscn")
var news_item_res = preload("res://scenes/news_flash.tscn")

var money_tween

@onready var stock_list = $VBoxContainer/main_layout/VBoxContainer/left/stonk_list/MarginContainer/VBoxContainer
@onready var desc_box = $VBoxContainer/main_layout/VBoxContainer/left/mid/VBoxContainer/graph_box/Panel/CompanyDescVis
@onready var news_list = $VBoxContainer/main_layout/news/news/ScrollContainer/VBoxContainer
@onready var news_scroll_cont = $VBoxContainer/main_layout/news/news/ScrollContainer
@onready var money_label = $VBoxContainer/header/HBoxContainer/money
@onready var graph = $VBoxContainer/main_layout/VBoxContainer/left/mid/VBoxContainer/graph_box/stonk_graph/MarginContainer/CenterContainer/StockGraph
@onready var timer = $VBoxContainer/header/HBoxContainer/TextureProgressBar


@onready var deck: Deck = $VBoxContainer/main_layout/VBoxContainer/MarginContainer/HBoxContainer/Panel/Deck
@onready var card_hand: CardHand = $VBoxContainer/main_layout/VBoxContainer/MarginContainer/HBoxContainer/CardHand
@onready var date_label = $VBoxContainer/header/HBoxContainer/date
@onready var sell_color_background = $VBoxContainer/main_layout/VBoxContainer/left/mid/HBoxContainer/VBoxContainer2/sell/sell_color
@onready var sell_emitter = $VBoxContainer/main_layout/VBoxContainer/left/mid/HBoxContainer/VBoxContainer2/sell/CenterContainer/GPUParticles2D

func _ready() -> void:
	clear_news()
	generate_stock_list()
	
	PlayerState.money_updated.connect(_on_money_updated)
	PlayerState.terminal_price_hiked.connect(set_terminal_fee)
	Market.market_update.connect(_on_market_update)
	
	Redaktionen.news_published.connect(_on_news_published)
	PlayerState.explode_particles.connect(_emit_sell_particles)
	_on_money_updated(0, PlayerState.money)


func set_terminal_fee():
	var fee = PlayerState.license_fee(PlayerState.day_index)
	$VBoxContainer/header/HBoxContainer2/fee_info.text = "License fee: $ " + str(fee)

func set_date(date):
	date_label.text = date

func set_timeout(time):
	timer.max_value = time
	timer.value = time

func generate_stock_list():
	for child in stock_list.get_children():
		child.free()
	
	for stock in Market.aktier:
		var stock_vis = stock_vis_res.instantiate()
		
		stock_vis.stock = stock
		stock_vis.set_title(stock.name)
		stock_vis.set_value(stock.value)
		
		
		stock_vis.show_description.connect(_on_stock_show_description)
		
		stock_list.add_child(stock_vis)
	_on_stock_show_description(Market.aktier[0])

func set_comp_desc(stock):
	desc_box.set_title(stock.name)
	desc_box.set_desc(stock.description)
	print(stock.logo)
	desc_box.set_logo(stock.logo)

func _on_stock_show_description(stock):
	set_comp_desc(stock)
	graph.set_stock(stock)
	

func _on_money_updated(old_val, new_val):
	if money_tween:
		money_tween.kill()
	
	money_tween = create_tween()
	money_tween.tween_method(set_money, old_val, new_val, abs(old_val - new_val) / 100)

func _on_market_update():
	graph.redraw_graph()
	timer.value -= 1
	if timer.value < 5:
		if timer.tint_progress != Color.RED:
			SfxPlayer.play_sfx("negative")
		timer.tint_progress = Color.RED
	elif timer.value < 10:
		timer.tint_progress = Color.YELLOW

func set_money(value):
	money_label.text = "$ " + str(int(value))

func clear_news():
	for child in news_list.get_children():
		child.free()

func _on_news_published(article):
	SfxPlayer.play_sfx("synth_jingle")
	var news_list_item = news_item_res.instantiate()
	news_list_item.set_news(article.title, article.description)
	news_list.add_child(news_list_item)
	news_list.move_child(news_list_item, 0)
	var scrollbar = news_scroll_cont.get_v_scroll_bar()
	scrollbar.ratio = 0
	$news_animationPlayer.play("news_flicker")
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	sell_color_background.color = Color.BLUE


func _on_area_2d_area_exited(area: Area2D) -> void:
	sell_color_background.color = Color.TRANSPARENT

func _emit_sell_particles():
	sell_emitter.restart()
	sell_emitter.emitting = true
	$AnimationPlayer.play("sell_flicker")
