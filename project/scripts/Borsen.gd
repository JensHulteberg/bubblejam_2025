class_name Borsen extends Node

var industrys: Array[Industri] = [
	Industri.new(1, "War"),
	Industri.new(2, "Health"),
	Industri.new(3, "Energy"),
	Industri.new(4, "Naughtyness"),
	Industri.new(5, "Food"),
	Industri.new(6, "Hospitality")
]

var aktier: Array[Aktie] = [
	Aktie.new(1, "Arnold & Wester", 1),
	Aktie.new(2, "Baas", 1),
	Aktie.new(3, "Alashnitev", 1),
	Aktie.new(4, "Kine", 2),
	Aktie.new(5, "Feel Good Inc.", 2),
	Aktie.new(7, "Tenton", 3),
	Aktie.new(8, "S.U.N.", 3),
	Aktie.new(9, "Vattenmakt", 3),
]

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 12345
	init_stocks()
	print_stocks()
	
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
	
