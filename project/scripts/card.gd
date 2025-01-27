@tool
class_name Card extends Control

signal back_to_hand
signal card_sold

@export var card_title: String = "CARD"
@export var image: Texture2D = preload("res://graphics/placeholder_card_image.png")
@export var description: String

@onready var card_title_label: Label = $MarginContainer/VBoxContainer/CardTitleLabel
@onready var image_texture_rect: TextureRect = $MarginContainer/VBoxContainer/MarginContainer2/ImageTextureRect

@onready var button: Button = $Button

var hover_tween
var hover_y_anchor = 0

var dragging: bool = false
var stock_id: int

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
		

func init(stock):
	card_title_label.text = stock.name
	image_texture_rect.texture = load(stock.logo)
	stock_id = stock.id

func disable():
	$Button.disabled = true

func enable():
	$Button.disabled = false

func _ready():
	_sync()
	pivot_offset.x = custom_minimum_size.x / 2
	pivot_offset.y = custom_minimum_size.y
	button.focus_mode = Control.FOCUS_NONE
	$MarginContainer/VBoxContainer/purch_label.modulate = Color.TRANSPARENT
	$MarginContainer/VBoxContainer/purch_price.modulate = Color.TRANSPARENT


func _process(delta: float):
	if Engine.is_editor_hint():
		_sync()
	
	if dragging:
		global_position = get_viewport().get_mouse_position() - (size / 2)

func set_purchase_price(price):
	$MarginContainer/VBoxContainer/purch_label.modulate = Color.WHITE
	$MarginContainer/VBoxContainer/purch_price.modulate = Color.WHITE
	$MarginContainer/VBoxContainer/purch_price.text = "$ " + str(price)

func _sync():
	card_title_label.text = card_title
	image_texture_rect.texture = image

func sell():
	SfxPlayer.play_sfx("positronic")
	PlayerState.emit_signal("explode_particles")
	Market.sell_stock(stock_id)
	
	emit_signal("card_sold")

func _on_button_button_down() -> void:
	dragging = true


func _on_button_button_up() -> void:
	dragging = false
	var overlapp = $CenterContainer/Area2D.get_overlapping_areas()
	
	for area in overlapp:
		if area.is_in_group("sell_area"):
			sell()
			return
	
	back_to_hand.emit()


func _on_button_mouse_entered() -> void:
	$Panel.self_modulate = Color.PURPLE


func _on_button_mouse_exited() -> void:
	$Panel.self_modulate = Color.WHITE
