@tool
class_name Card extends Control

@export var card_title: String = "CARD"
@export var image: Texture2D = preload("res://graphics/placeholder_card_image.png")
@export var description: String

@onready var card_title_label: RichTextLabel = $MarginContainer/VBoxContainer/MarginContainer/CardTitleLabel
@onready var image_texture_rect: TextureRect = $MarginContainer/VBoxContainer/MarginContainer2/ImageTextureRect

var anchor_x:
	get:
		return anchor_left
	set(value):
		anchor_left = value
		anchor_right = value
var anchor_y:
	get:
		return anchor_top
	set(value):
		anchor_top = value
		anchor_bottom = value
var offset:
	get:
		return offset_left
	set(value):
		offset_left = value
		offset_right = value
		offset_top = value
		offset_bottom = value
		

func _ready():
	_sync()
	pivot_offset.x = custom_minimum_size.x / 2
	pivot_offset.y = custom_minimum_size.y

func _process(delta: float):
	if Engine.is_editor_hint():
		_sync()

func _sync():
	card_title_label.text = "[center]" + card_title + "[/center]"
	image_texture_rect.texture = image
