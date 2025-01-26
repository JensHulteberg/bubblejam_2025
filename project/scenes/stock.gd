extends Button

var stock: Aktie:
	set(new_stock):
		stock = new_stock
		stock.aktie_update.connect(_on_aktie_update)
signal show_description

func set_title(name):
	$VBoxContainer/HBoxContainer/title.text = name

func set_value(value):
	var trend = stock.trend()
	
	var trend_symbol = "-"
	
	if trend > 0:
		trend_symbol = "[color=green]▲[/color]"
	else:
		trend_symbol = "[color=red]▼[/color]"
	
	$VBoxContainer/HBoxContainer/value.text = "$ " + str(value) + " " + trend_symbol


func _on_mouse_entered() -> void:
	emit_signal("show_description", stock)
	SfxPlayer.play_sfx("woosh", 0.5 + stock.id * 0.1, -5.0 - stock.id * 0.1)
	$VBoxContainer/HBoxContainer/title["theme_override_colors/font_color"] = Color(Color.BLACK)
	$VBoxContainer/HBoxContainer/value["theme_override_colors/default_color"] = Color(Color.BLACK)
	
	


func _on_mouse_exited() -> void:
	$VBoxContainer/HBoxContainer/title["theme_override_colors/font_color"] = Color(Color.WHITE)
	$VBoxContainer/HBoxContainer/value["theme_override_colors/default_color"] = Color(Color.WHITE)

func _on_aktie_update():
	set_title(stock.name)
	set_value(stock.value)
