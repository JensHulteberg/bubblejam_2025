class_name Aktie

var id: int
var amount: int
var value: int
var industry: String
var history: Array[HistoricAktie]

func _init(_id: int, _industry: String) -> void:
	

class HistoricAktie:
	var date: int
	var value: int
	var amount: int
	
