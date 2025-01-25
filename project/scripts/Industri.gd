class_name Industri

var id: int
var name: String

# manipulations
var reset_ticks: int = 0
var bubble: bool = false
var boost: int = 0

func _init(_id: int, _name: String) -> void:
	id = _id
	name = _name
	

func manipulate(ticks: int, _bubble:bool = false, _boost: int = 0) -> void:
	reset_ticks = ticks
	bubble = _bubble
	boost = _boost
	
func reset_manipulations() -> void:
	reset_ticks = 0
	bubble = false
	boost = 0
	
func get_industry_manipulation(pre: int) -> int:
	if reset_ticks == 0:
		return pre
		
	var post = pre
	
	post += boost
	
	if bubble:
		post = abs(pre)
		post *= 2
	
	reset_ticks -= 1
	if reset_ticks <= 0:
		reset_manipulations()
	
	return post
