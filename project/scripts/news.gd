class_name News

var id: int
var title: String
var description: String
var industry_manipulation: Callable
var aktie_manipulation: Callable

func _init(_id: int, _title: String, _desciption: String, ind_manipulation: Callable, stock_manipulation: Callable) -> void:
	id = _id
	title = _title
	description = _desciption
	industry_manipulation = ind_manipulation
	aktie_manipulation = stock_manipulation

func manipulate() -> void:
	if industry_manipulation != null:
		industry_manipulation.call()
	if aktie_manipulation != null:
		aktie_manipulation.call()
