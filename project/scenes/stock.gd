extends Button

var stock: Aktie
signal show_description

func set_title(name):
	$VBoxContainer/HBoxContainer/title.text = name

func set_value(value):
	$VBoxContainer/HBoxContainer/value.text = "$ " + str(value)


func _on_mouse_entered() -> void:
	emit_signal("show_description", stock)
	$VBoxContainer/HBoxContainer/title["theme_override_colors/font_color"] = Color(Color.BLACK)
	$VBoxContainer/HBoxContainer/value["theme_override_colors/font_color"] = Color(Color.BLACK)
	
	


func _on_mouse_exited() -> void:
	$VBoxContainer/HBoxContainer/title["theme_override_colors/font_color"] = Color(Color.WHITE)
	$VBoxContainer/HBoxContainer/value["theme_override_colors/font_color"] = Color(Color.WHITE)
