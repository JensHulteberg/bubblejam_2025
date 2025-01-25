class_name Aktie

signal aktie_update

var id: int
var name: String
var description: String
var amount: int
var value: int
var logo: String
var sell_spell: Callable

# base rngs stats
var upper_bound = 10
var lower_bound = -10

# Manipulations
var reset_ticks: int = 0
var only_up: bool = false
var only_down: bool = false
var boost: int = 0

var industry_id: int

var history: Array[HistoricAktie]

func _init(_id: int, _name: String, _industry: int, _description: String, _logo : String, spell: Callable) -> void:
	id = _id
	name = _name
	industry_id = _industry
	description = _description
	logo = _logo
	sell_spell = spell
	
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
	var lower = lower_bound
	var upper = upper_bound

	if only_up:
		lower = 1
		upper += 1
		
	if only_down: 
		upper = -1
		lower -= 1
	
	var delta = Market.rng.randi_range(lower, upper)
	if reset_ticks > 0:
		delta += boost
		reset_ticks -= 1
		
	var industry = Market.get_industry_by_id(industry_id)
	delta = industry.get_industry_manipulation(delta)

	push_value(value + delta)
	
	if reset_ticks <= 0:
		reset_manipulation()
	
func min_max_values () -> Vector2:
	var values = history.map(func(h): return h.value)
	values.append(value)
	return Vector2(values.min(), values.max())

func trend() -> int:
	var look_back_size = 10
	var look_back = history.slice(history.size() -look_back_size, history.size())
	var mean_look_back =  look_back.map(func(h): return h.value).reduce(func(v, acc): return v + acc, 0) / look_back_size 
	return value - mean_look_back

func manipulate(ticks: int, _only_up: bool = false, _only_down: bool = false, _boost = 0) -> void:
	reset_ticks = ticks
	only_up = _only_up
	only_down = _only_down
	boost = _boost
	
func reset_manipulation() -> void:
	reset_ticks = 0
	only_up = false
	only_down = false
	boost = 0

func sell() -> int:
	sell_spell.call(self)
	return value
