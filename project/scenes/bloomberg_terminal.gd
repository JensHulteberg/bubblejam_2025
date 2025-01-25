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

func _ready() -> void:
	clear_news()
	generate_stock_list()
	PlayerState.money += 1000
	
	PlayerState.money_updated.connect(_on_money_updated)
	Market.market_update.connect(_on_market_update)

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

func set_comp_desc(stock):
	desc_box.set_title(stock.name)
	desc_box.set_desc(stock.description)

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

func set_money(value):
	money_label.text = "$ " + str(int(value))

func clear_news():
	for child in news_list.get_children():
		child.free()

func add_news(title, desc):
	var news_list_item = news_item_res.instantiate()
	news_list_item.set_news(title, desc)
	news_list.add_child(news_list_item)
	news_list.move_child(news_list_item, 0)
	var scrollbar = news_scroll_cont.get_v_scroll_bar()
	scrollbar.ratio = 0
	
