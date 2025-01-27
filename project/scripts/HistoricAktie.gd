class_name HistoricAktie
var date: int
var value: int
var amount: int
var bought: bool
var sold: bool
	
func _init(_value: int, _amount:int, _bought: bool, _sold: bool) -> void:
	value = _value
	amount = _amount
	bought = _bought
	sold = _sold
	
