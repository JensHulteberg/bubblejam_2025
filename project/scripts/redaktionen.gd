extends Node

signal news_published

var news: Array[News] = [
	News.new(1, "It's going great!", "The market is up on all fronts!",
	 func():
		for i in range(6):
			Market.manipulate_industry(i, 10, false, 3), 
	func(): pass),
	News.new(2, "Extra Extra!", "Extra! It's all Extra! Get it while it's Extra!", 
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
	News.new(7, "Kine not so kind", "Kine CEO accused of not brewing new coffee when the pot is empty.",
	func(): pass, func(): Market.manipulate_stock(4, 10, false, false, -2)),
	News.new(8, "Impressive plan", "Tentron has announced a new benefits package with a healthy pension plan.",
	func(): pass, func(): Market.manipulate_stock(7, 10, false, false, 7)),
	News.new(9, "Energetic industry", "Electric usage at an all time high across the globe, the private sector is hungry for more.",
	func(): Market.manipulate_industry(3, 10, true, 0), func(): pass),
	News.new(10, "New winds", "Strong winds bring strong currents for Vattenmakt's patented Aerodams.",
	func(): pass, func(): Market.manipulate_stock(9, 10, true, false, 0)),
]

var bubble_news: Array[News] = [
	News.new(1, "Sunny days", "Bright lights, shining S.U.N, will the nice weather last?",
	func(): pass, 
	func(): 
		Market.manipulate_stock(7, 24, false, true, -6)
		Market.manipulate_stock(8, 30, false, false, 8)
		Market.manipulate_stock(9, 24, false, true, 0)),
	News.new(2, "Going nuts", "The public is going nuts for the new nuts-derived supplement.",
	func(): pass, func(): Market.manipulate_stock(5, 40, true, false, 0)),
	News.new(3, "Kine is kind", "Kine records record profits and announces large donation spree.",
	func(): pass, func(): Market.manipulate_stock(4, 40, true, false, 2)),
	News.new(4, "War breaks out", "War breaks out at the western coast of UWN.",
	func(): Market.manipulate_industry(1, 90, true, 0), 
	func(): 
		Market.manipulate_stock(5, 22, false, true, 0)
		Market.manipulate_stock(7, 22, false, true, 0)
		Market.manipulate_stock(8, 22, false, true, 0)
		),
	News.new(5, "Energy demands", "Energy demands at an all time high, industry positively electric",
	func(): 
		Market.manipulate_industry(2, 60, false, 20)
		Market.manipulate_stock(2, 22, false, true, 0),
	 func(): pass),
	News.new(6, "Feeling focused", "Feel Good Inc. focuses efforts on soldier-enhancing drugs.",
	func(): pass, func(): Market.manipulate_stock(5, 40, false, false, 6)),
	News.new(7, "Arming up", "Increased demands for large, small, and physo-arms. Large arms in high demand.",
	func(): pass, 
	func(): 
		Market.manipulate_stock(2, 22, false, false, 8)
		Market.manipulate_stock(4, 22, false, true, 0)
		Market.manipulate_stock(7, 22, false, true, 0)
		),
	News.new(8, "Feeling the flow", "EAZ gives the clear to use max capacity for all dams to satisfy increased demands.",
	func(): pass, func(): Market.manipulate_stock(2, 60, false, false, 8)),
	News.new(9, "Electric records", "Energy sector is recording record profits!",
	func(): Market.manipulate_industry(3, 30, false, 8), func(): pass),
	News.new(10, "Fashion trends", "Fashion trends have shifted to military-inspired fitness gear, the health industry is booming.",
	func(): 
		Market.manipulate_industry(2, 30, true, 6)
		Market.manipulate_stock(1, 16, false, true, 0)
		Market.manipulate_stock(2, 22, false, true, 0)
		Market.manipulate_stock(3, 12, false, true, 0)
		Market.manipulate_stock(8, 22, false, true, 0),
	 func(): pass),
	News.new(11, "News on western coast", "UWNA reports pushing back the rogue nations with great success. Predicts a long military effort to keep the peace.",
	func(): Market.manipulate_industry(1, 30, true, 12), func(): pass),
	News.new(12, "Joint venture", "Tentron, Vattenmakt and S.U.N. announce a joint venture in producing energy for the public sector.",
	func(): Market.manipulate_industry(3, 30, true, 18), func(): pass),
	News.new(13, "BÖRSEN going strong", "All industries are reporting record profits!",
	func(): 
		Market.manipulate_industry(1, 30, true, 32)
		Market.manipulate_industry(2, 30, true, 32)
		Market.manipulate_industry(3, 30, true, 32)
		for a in Market.aktier:
			Market.manipulate_stock(a.id, 0, false, false, 0)
			,
		func(): pass),
	News.new(14, "Mindscape case solved", "Local police officer solved the harrowing case that took place earlier this year. He was promoted to detective for his efforts.",
	func(): pass, func(): pass),
	News.new(15, "EAZ Finsum 2057 opens", "Oscar Wallberg opens the summit to thunderous applause, reassuring the audience that the current market is not a bubble but a correction to previous levels.",
	func(): pass, func(): pass),
]

var burst_news: Array[News] = [
	News.new(1, "Tentron plans anger", "Tentron accused of shutting down facilities in order to inflate energy prices.",
	func(): pass, 
	func(): Market.manipulate_stock(7, 30, false, true, -20)),
	News.new(1, "S.U.N.S. setting ", "Increased radiodust covering large parts of S.U.N.'s solar farms. S.U.N. unable to deliver on promises.",
	func(): pass, 
	func(): Market.manipulate_stock(8, 30, false, false, -10)),
	News.new(1, "Feel Bad Inc.", "New suppliments delivered for the war effort triggers epilepsy in 1/10.",
	func(): pass, 
	func(): Market.manipulate_stock(5, 30, false, true, -30)),
	News.new(1, "Vattenmakt losing power", "Neglected upkeep keeps dams from running on full effect. Joint energy venture scrambling to find alternative sources.",
	func(): Market.manipulate_industry(2, 30, false, -8), 
	func(): pass),
	News.new(1, "Licensing update", "Gloomberg & Sons announces an updated licensing fee structure. According to G&S it should reflect the current market and its traders' needs.",
	func(): PlayerState.hike_terminal_fee(0), 
	func(): pass),
	News.new(1, "None of a kind", "Kine unable to deliver thermo camo for the UWNA in time. Blames factories shutting down on lack of energy.",
	func(): Market.manipulate_industry(2, 10, false, -16), 
	func(): pass),
	News.new(1, "ArnOLD & Wester", "Increased shatter in the miltok space accuses A&W of delivering rusty weapons systems to newer recruits.",
	func(): pass, 
	func(): Market.manipulate_stock(1, 30, false, true, -6)),
	News.new(1, "Kine CEO steps down", "Interim CEO cites various coffee-related reasons.",
	func(): pass, 
	func(): Market.manipulate_stock(1, 30, false, true, -8)),
	News.new(1, "Lights off for the UWNA", "United Western Nations and Eurafrican Zone present a new way to help the war effort. Just switch off your appliances during the day and night!",
	func(): 
		Market.manipulate_industry(1, 30, false, -20)
		Market.manipulate_industry(3, 30, false, -13), 
	func(): pass),
	News.new(1, "FGIs new CSO", "Feel Good Inc. announces a new CSO with great experience from the health industry.",
	func(): Market.manipulate_industry(2, 30, false, -20), 
	func(): pass),
	News.new(1, "Helping hands", "Citizens urged to help the war effort in any way they can. See Theo 7y is helping with his family.",
	func():
		Market.manipulate_industry(1, 30, false, -40)
		Market.manipulate_industry(2, 30, false, -40)
		Market.manipulate_industry(3, 30, false, -40), 
	func(): pass),
	News.new(1, "BÖRSEN restructuring", "United Western Nations and Eurafrican Zone announces a takeover of BÖRSEN at the end of the year to strengthen the market.",
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
	else:
		publish_news_item(
			News.new(10 + PlayerState.day_index, "BÖRSEN SHUTDOWN", "Gloomberg & Sons announcing new terminal fee.",
			func(): 	
				PlayerState.hike_terminal_fee(PlayerState.license_fee(PlayerState.day_index) + PlayerState.day_index * 1000)
				Market.manipulate_industry(1, 300, false, -100)
				Market.manipulate_industry(2, 300, false, -100)
				Market.manipulate_industry(3, 300, false, -100), 
			func(): pass))
	
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
