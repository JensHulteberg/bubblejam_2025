class_name News

var id: int
var title: String
var description: String
var market_manipulation: Callable

func _init(_id: int, _title: String, _desciption: String, _market_manipulation: Callable) -> void:
	id = _id
	title = _title
	description = _desciption
	market_manipulation = _market_manipulation

func manipulate() -> void:
	if market_manipulation != null:
		market_manipulation.call()
