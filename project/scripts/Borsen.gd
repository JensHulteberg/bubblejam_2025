class_name Borsen extends Node

signal market_update

var industrys: Array[Industri] = [
	Industri.new(1, "War"),
	Industri.new(2, "Health"),
	Industri.new(3, "Energy"),
	Industri.new(4, "Naughtyness"),
	Industri.new(5, "Food"),
	Industri.new(6, "Hospitality")
]

var aktier: Array[Aktie] = [
	Aktie.new(1, "Arnold & Wester", 1, "res://graphics/aw_logo.png"),
	Aktie.new(2, "Baas", 1, "res://graphics/baas_logo.png"),
	Aktie.new(3, "Alashnitev", 1, "res://graphics/alashnitev_logo.png"),
	Aktie.new(4, "Kine", 2, "res://graphics/kine_logo.png"),
	Aktie.new(5, "Feel Good Inc.", 2, "res://graphics/feel_good_logo.png"),
	Aktie.new(7, "Tenton", 3, "res://graphics/tenton_logo.png"),
	Aktie.new(8, "S.U.N.", 3, "res://graphics/sun_logo.png"),
	Aktie.new(9, "Vattenmakt", 3, "res://graphics/vattenkraft_logo.png"),
]

var rng = RandomNumberGenerator.new()

var timer: Timer

func _ready() -> void:
	rng.seed = 12345
	init_stocks()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	
func _on_timer_timeout() -> void:
	update()
	
func print_stocks() -> void:
	for a in aktier:
		a.print_me()
		a.print_history()


func init_stocks() -> void:
	for a in aktier: 
		a.value = rng.randi_range(5, 100)
		a.amount = rng.randi_range(100, 10000)
		for i in range(0, 100):
			a.step_value()
	
func buy_stock(stock_id: int) -> void:
	pass


func update() -> void:
	for a in aktier: 
		a.step_value()
	emit_signal("market_update")
	
