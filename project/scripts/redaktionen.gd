extends Node

signal news_published

var news: Array[News] = [
	News.new(1, "Its going great!", "The markets up on all fronts!"),
	News.new(2, "Extra Extra!", "Extra! Its all Extra! Get it while its Extra!"),
	News.new(3, "Scandalous accusatios", "The people did what they were really not supposed to do. This is not good."),
	News.new(4, "New weapons!", "Weapons are great! A&W has created new ones that go bang bang.")
]

var published_news: Array[News] = []

func get_latest_news_item() -> News:
	return news.front()

func publish_news_item(id: int) -> void:
	var news_to_publish = news.filter(func(n): return n.id == id)
	if news_to_publish != null:
		published_news.push_front(news)
	emit_signal("news_published", news)
