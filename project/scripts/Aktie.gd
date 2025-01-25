class_name Aktie

signal aktie_update

var id: int
var name: String
var description: String
var amount: int
var value: int
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
	push_value(value + Market.rng.randi_range(-10, 10))
	
func min_max_values () -> Vector2:
	var values = history.map(func(h): return h.value)
	values.append(value)
	return Vector2(values.min(), values.max())

func trend() -> int:
	var look_back_size = 10
	var look_back = history.slice(history.size() -look_back_size, history.size())
	var mean_look_back =  look_back.map(func(h): return h.value).reduce(func(v, acc): return v + acc, 0) / look_back_size 
	return value - mean_look_back
	
