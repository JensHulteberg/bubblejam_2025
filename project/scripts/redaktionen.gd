extends Node

signal news_published

var news: Array[News] = [
	News.new(1, "Its going great!", "The markets up on all fronts!",
	 func():
		for i in range(6):
			Market.manipulate_industry(i, 10, false, 3), 
	func(): pass),
	News.new(2, "Extra Extra!", "Extra! Its all Extra! Get it while its Extra!", 
	func(): pass, func(): 
		for a in range(9):
			Market.manipulate_stock(a, 10, true, false, 0)
		),
	News.new(3, "Scandalous accusatios", "The people did what they were really not supposed to do. This is not good.", 
	func(): pass, func(): Market.manipulate_stock(3, 90, false, true, false)),
	News.new(4, "New weapons!", "Weapons are great! A&W has created new ones that go bang bang.",
	func(): pass, func(): Market.manipulate_stock(1, 40, false, false, 5))
]

var published_news: Array[News] = []

var news_timer_limit: int = 8
var news_timer:int = 0

func _ready() -> void:
	Market.market_update.connect(_on_market_update)
	
func reset() -> void:
	published_news = []
	news_timer_limit = 0
	
func _on_market_update() -> void:
	news_timer += 1
	if news_timer >= news_timer_limit:
		news_timer = 0
		publish_random_news_item()
	
func publish_random_news_item() -> void:
	var publish_me = news.filter(func(n): return published_news.find(n) < 0).pick_random()
	if publish_me != null:
		publish_news_item(publish_me.id)
		
func get_latest_news_item() -> News:
	return news.front()

func publish_news_item(id: int) -> void:
	var news_to_publish = news.filter(func(n): return n.id == id).front()

	if news_to_publish != null:
		news_to_publish.manipulate()
		published_news.push_front(news_to_publish)
		emit_signal("news_published", news_to_publish)
