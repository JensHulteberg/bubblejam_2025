class_name Aktie

var id: int
var name: String
var amount: int
var value: int
var industry_id: int
var history: Array[HistoricAktie]

func _init(_id: int, _name: String, _industry: int) -> void:
	id = _id
	name = _name
	industry_id = _industry
	
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
	
func step_value() -> void:
	push_value(value + Market.rng.randi_range(-10, 10))
	
func min_max_values () -> Vector2:
	var values = history.map(func(h): return h.value)
	values.append(value)
	return Vector2(values.min(), values.max())
	
