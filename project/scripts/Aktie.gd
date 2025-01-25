class_name Aktie

signal aktie_update

var id: int
var name: String
var description: String
var amount: int
var value: int

# base rngs stats
var test = 0

# Manipulations
var reset_ticks: int = 0
var only_up: bool = false
var only_down: bool = false

var industry_id: int

var history: Array[HistoricAktie]

func _init(_id: int, _name: String, _industry: int) -> void:
	id = _id
	name = _name
	industry_id = _industry
	description = "Lorem ipsum."
	
func print_me() -> void:
	print("id: %s name: %s amount: %s value: %s market_cap: %s" % [id, name, amount, value, market_cap()])
	
func print_history() -> void:
	for h in history:
		print("value: %s amount: %s" % [h.value, h.amount])
	
func market_cap() -> int:
	return amount * value
	
func push_value(_value: int) -> void:
	history.append(HistoricAktie.new(value, amount))
	value = max(_value, 0)
	emit_signal("aktie_update")
	
func step_value() -> void:
	var lower = -10
	var upper = 10
	
	if only_up:
		lower = 1
		upper += 1
		
	if only_down: 
		upper = -1
		lower -= 1
	
	if reset_ticks > 0:
		reset_ticks -= 1
		reset_manipulation()
	push_value(value + Market.rng.randi_range(lower, upper))
	
func min_max_values () -> Vector2:
	var values = history.map(func(h): return h.value)
	values.append(value)
	return Vector2(values.min(), values.max())

func trend() -> int:
	var look_back_size = 10
	var look_back = history.slice(history.size() -look_back_size, history.size())
	var mean_look_back =  look_back.map(func(h): return h.value).reduce(func(v, acc): return v + acc, 0) / look_back_size 
	return value - mean_look_back

func manipulate(ticks: int, only_up: bool = false, only_down: bool = false) -> void:
	reset_ticks = ticks
	only_up = only_up
	only_down = only_down
	
func reset_manipulation() -> void:
	reset_ticks = 0
	only_up = false
	only_down = false
