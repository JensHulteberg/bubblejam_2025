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
	News.new(3, "Scandalous accusations", "Alashnitev did what they were really not supposed to do. This is not good.", 
	func(): pass, func(): Market.manipulate_stock(3, 10, false, true, false)),
	News.new(4, "New weapons!", "Weapons are great! A&W has created new ones that go bang bang.",
	func(): pass, func(): Market.manipulate_stock(1, 10, false, false, 5)),
	News.new(5, "Healthy market", "Fit in with fitness, try to fit in some fitness stocks into your portfolio.",
	func(): Market.manipulate_industry(2, 5, true, 0), func(): Market.manipulate_stock(4, 10, false, false, 3)),
	News.new(6, "Tensions at the border", "Tensions are high along UNW west coast. Uncertain future for the fragile peace treaty.",
	func(): Market.manipulate_industry(1, 10, false, 5), func(): Market.manipulate_stock(4, 10, false, false, 5)),
	News.new(7, "Kine not so kind", "Kine CEO accused of not brewing new coffe when the pot is empty.",
	func(): pass, func(): Market.manipulate_stock(4, 10, false, false, -2)),
	News.new(8, "Impressive plan", "Tentron has announced an new benefits package with a healthy pension plan.",
	func(): pass, func(): Market.manipulate_stock(7, 10, false, false, 7)),
	News.new(9, "Energetic industry", "Electric usage at an all time high accross the globe, the private sector is hungry for more.",
	func(): Market.manipulate_industry(3, 10, true, 0), func(): pass),
	News.new(10, "New winds", "Strong winds bring strong currents for Vattenmakts patented Aerodams",
	func(): pass, func(): Market.manipulate_stock(9, 10, true, false, 0)),
]

var bubble_news: Array[News] = [
	News.new(1, "Sunny days", "Bright lights shining S.U.N, will the nice weather last?",
	func(): pass, func(): Market.manipulate_stock(8, 25, false, false, 8)),
	News.new(2, "Going nuts", "The public is going nuts for the new nuts derived supplement",
	func(): pass, func(): Market.manipulate_stock(8, 20, true, false, 0)),
	News.new(3, "Kine is kined", "Kine records record profits and announces large donation spree",
	func(): pass, func(): Market.manipulate_stock(4, 20, true, false, 2)),
	News.new(4, "War breaks out", "War breaks out at the western coast of UWN.",
	func(): Market.manipulate_industry(1, 30, true, 0), func(): pass),
	News.new(5, "Energy demands", "Energy demands at an all time high, industry positivly electric",
	func(): Market.manipulate_industry(2, 20, false, 20), func(): pass),
	News.new(6, "Feeling Focused", "Feel Good Inc. focuses efforts on soldier enhancing drugs",
	func(): pass, func(): Market.manipulate_stock(5, 20, false, false, 6)),
	News.new(7, "7", "war industry good, one better, baas",
	func(): Market.manipulate_industry(1, 30, true, 0), func(): Market.manipulate_stock(2, 20, false, false, 8)),
	News.new(8, "8", "vattenmakt good",
	func(): pass, func(): Market.manipulate_stock(2, 20, false, false, 8)),
	News.new(9, "9", "energy good",
	func(): Market.manipulate_industry(3, 30, false, 8), func(): pass),
	News.new(10, "10", "health good",
	func(): Market.manipulate_industry(2, 30, true, 0), func(): pass),
	News.new(11, "11", "war good ",
	func(): Market.manipulate_industry(1, 30, true, 0), func(): pass),
	News.new(12, "12", "energy good",
	func(): Market.manipulate_industry(1, 30, true, 0), func(): pass),
]

var burst_news: Array[News] = [
	News.new(1, "burst 1", "tentron fakes energy",
	func(): pass, 
	func(): Market.manipulate_stock(7, 30, false, true, -20)),
	News.new(1, "burst 2", "SUN not good",
	func(): pass, 
	func(): Market.manipulate_stock(8, 30, false, false, -10)),
	News.new(1, "burst 3", "Feel bad inc  ",
	func(): pass, 
	func(): Market.manipulate_stock(5, 30, false, true, -30)),
	News.new(1, "burst 4", "energy bad",
	func(): Market.manipulate_industry(2, 30, false, -8), 
	func(): pass),
	News.new(1, "burst 5", "Terminal price hike!!",
	func(): PlayerState.hike_terminal_fee(), 
	func(): pass),
	News.new(1, "burst 6", "health ind bad",
	func(): Market.manipulate_industry(2, 30, false, -16), 
	func(): pass),
	News.new(1, "burst 7", "a&w cant deliver",
	func(): pass, 
	func(): Market.manipulate_stock(1, 30, false, true, -6)),
	News.new(1, "burst 8", "kine to hell",
	func(): pass, 
	func(): Market.manipulate_stock(1, 30, false, true, -8)),
	News.new(1, "burst 9", "energy and war bad",
	func(): 
		Market.manipulate_industry(1, 30, false, -20)
		Market.manipulate_industry(3, 30, false, -13), 
	func(): pass),
	News.new(1, "burst 10", "health industry follows",
	func(): Market.manipulate_industry(2, 30, false, -20), 
	func(): pass),
	News.new(1, "burst 11", "all bad",
	func():
		Market.manipulate_industry(1, 30, false, -40)
		Market.manipulate_industry(2, 30, false, -40)
		Market.manipulate_industry(3, 30, false, -40), 
	func(): pass),
	News.new(1, "burst 12", "worse",
	func(): 		
		Market.manipulate_industry(1, 300, false, -100)
		Market.manipulate_industry(2, 300, false, -100)
		Market.manipulate_industry(3, 300, false, -100), 
	func(): pass),
]

var published_news: Array[News] = []

var news_timer_limit: int = 8
var news_timer:int = 0

var bubble_on: bool = false
var burst_on: bool = false

func _ready() -> void:
	Market.market_update.connect(_on_market_update)
	
func reset() -> void:
	#published_news = []
	news_timer = 0
	
func _on_market_update() -> void:
	news_timer += 1
	if news_timer >= news_timer_limit:
		news_timer = 0
		if burst_on:
			publish_burst_news_item()
		elif bubble_on:
			publish_bubble_news_item()
		else:
			publish_random_news_item()
	
func publish_bubble_news_item() -> void:
	var news_item = bubble_news.pop_front()
	if news_item != null:
		publish_news_item(news_item)
	
func publish_burst_news_item() -> void:
	var news_item = burst_news.pop_front()
	if news_item != null:
		publish_news_item(news_item)
	
func publish_random_news_item() -> void:
	var publish_me = news.filter(func(n): return published_news.find(n) < 0).pick_random()
	if publish_me != null:
		publish_news_item(publish_me)
		
func get_latest_news_item() -> News:
	return news.front()

func publish_news_item(news_to_publish: News) -> void:
	if news_to_publish != null:
		news_to_publish.manipulate()
		published_news.push_front(news_to_publish)
		emit_signal("news_published", news_to_publish)
