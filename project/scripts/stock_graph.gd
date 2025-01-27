extends Node2D

@export var width: float = 492
@export var height: float = 91
@export var col_up: Color = Color.GREEN
@export var col_down: Color = Color.RED
@export var col_buy: Color = Color.WHITE
@export var col_sell: Color = Color.BLUE
@export var col_buy_and_sell: Color = Color.CYAN

var aktie: Aktie 

func set_stock(_aktie: Aktie) -> void:
	aktie = _aktie
	queue_redraw()

func redraw_graph():
	queue_redraw()

func _draw() -> void:
	#draw_border()
	if (aktie == null):
		return
	var step_len =  width / aktie.history.size()
	var height_div = aktie.min_max_values().y / height
	draw_aktie(aktie, step_len, height_div)
	
	
func draw_border() -> void:
	draw_polyline(
	[Vector2(0, 0), 
	Vector2(width, 0), 
	Vector2(width, height), 
	Vector2(0.0, height), 
	Vector2(0.0, 0)
	], Color.WHITE, 1.0)

class BuySellPos:
	var h: HistoricAktie
	var pos: Vector2

func draw_aktie(a: Aktie, step_len: float, height_div: float) -> void:
	var coords: PackedVector2Array = []
	var colors: PackedColorArray = []
	var idx: int = 0
	var last_value: int
	var buy_sell_rings: Array[BuySellPos] = []
	
	for h in a.history:
		var pos = give_vector(h.value, idx, step_len, height_div)
		if h.bought or h.sold:
			var bps = BuySellPos.new()
			bps.h = h
			bps.pos = pos
			buy_sell_rings.append(bps)
		coords.append(give_vector(h.value, idx, step_len, height_div))
		if last_value != null:
			colors.append(get_color(h.value, last_value))
		idx += 1
		last_value = h.value
		
	coords.append(give_vector(a.value, idx, step_len, height_div))
	colors.append(get_color(a.value, last_value))
	draw_polyline_colors(coords, colors, 1.0)
	for bps in buy_sell_rings:
		draw_buy_sell(bps.h, bps.pos)
	

func get_color(value: int, last_value: int) -> Color:
	if last_value < value:
		return col_up
	else:
		return col_down

func draw_buy_sell(h: HistoricAktie, pos: Vector2) -> void:
	var color = col_buy
	if h.sold and h.bought: 
		color = col_buy_and_sell
	elif h.sold: 
		color = col_sell
		
	draw_circle(pos, 3, color)
		

func give_vector(value: int, idx: int, step_len: float, height_div: float) -> Vector2:
	return Vector2(idx * step_len, -(value / height_div) + height)
