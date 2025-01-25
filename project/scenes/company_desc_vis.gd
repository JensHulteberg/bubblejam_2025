extends MarginContainer

func set_title(title):
	$VBoxContainer/Label.text = title
	reset_text()

func set_logo(path):
	$VBoxContainer/HBoxContainer/TextureProgressBar.texture_progress = load(path)
	$VBoxContainer/HBoxContainer/TextureProgressBar.value = 0

func set_desc(desc):
	$VBoxContainer/HBoxContainer/RichTextLabel.text = desc
	reset_text()

func reset_text():
	$VBoxContainer/Label.visible_characters = 0
	$VBoxContainer/HBoxContainer/RichTextLabel.visible_characters = 0

func _process(delta: float) -> void:
	$VBoxContainer/Label.visible_characters += 1
	$VBoxContainer/HBoxContainer/RichTextLabel.visible_characters += 1
	$VBoxContainer/HBoxContainer/TextureProgressBar.value += 1
