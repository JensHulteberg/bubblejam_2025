extends MarginContainer

func set_title(title):
	$VBoxContainer/Label.text = title
	reset_text()

func set_desc(desc):
	$VBoxContainer/RichTextLabel.text = desc
	reset_text()

func reset_text():
	$VBoxContainer/Label.visible_characters = 0
	$VBoxContainer/RichTextLabel.visible_characters = 0

func _process(delta: float) -> void:
	$VBoxContainer/Label.visible_characters += 1
	$VBoxContainer/RichTextLabel.visible_characters += 1
