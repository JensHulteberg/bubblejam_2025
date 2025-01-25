extends MarginContainer

func set_news(title, desc):
	$VBoxContainer/Label.text = title
	$VBoxContainer/RichTextLabel.text = desc
	$VBoxContainer/Label.visible_characters = 0
	$VBoxContainer/RichTextLabel.visible_characters = 0

func _process(delta: float) -> void:
	$VBoxContainer/Label.visible_characters += 1
	$VBoxContainer/RichTextLabel.visible_characters += 1
