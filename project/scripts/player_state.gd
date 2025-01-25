extends Node

signal money_updated

var money = 0 :
	set(value):
		emit_signal("money_updated", money, value)
		money = value
