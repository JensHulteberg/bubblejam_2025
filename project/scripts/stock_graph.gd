extends Node2D

var width: float = 492
var height: float = 91
var aktie: Aktie 

func set_stock(_aktie: Aktie) -> void:
	
	aktie = _aktie
	queue_redraw()

func _draw() -> void:
	#draw_border()
	if (aktie == null):
		return
	var step_len =  width / aktie.history.size()
	var height_div = aktie.min_max_values().y / height
	var aktie_line = _aktie_to_Vector2Array(aktie, step_len, height_div)
	draw_polyline(aktie_line, Color.GREEN, 1.0)
	
	
func draw_border() -> void:
	draw_polyline(
	[Vector2(0, 0), 
	Vector2(width, 0), 
	Vector2(width, height), 
	Vector2(0.0, height), 
	Vector2(0.0, 0)
	], Color.WHITE, 1.0)


func _aktie_to_Vector2Array(a: Aktie, step_len: float, height_div: float) -> PackedVector2Array:
	var coords: PackedVector2Array = []
	var idx: int = 0;
	for h in a.history:
		coords.append(give_vector(h.value, idx, step_len, height_div))
		idx += 1
	coords.append(give_vector(a.value, idx, step_len, height_div))
	return coords

func give_vector(value: int, idx: int, step_len: float, height_div: float) -> Vector2:
	return Vector2(idx * step_len, -(value / height_div) + height)
