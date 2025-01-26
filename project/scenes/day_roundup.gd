extends Control

func _ready() -> void:
	set_process(false)

func init(day_num: int, cash: int, stocks_value: int, licence_fee: int):
	$CenterContainer/VBoxContainer/Label.text = "MARKET CLOSING DAY " + str(day_num)
	$CenterContainer/VBoxContainer/HBoxContainer/Label2.text = "$ " + str(cash) 
	$CenterContainer/VBoxContainer/HBoxContainer2/Label2.text = "$ " + str(stocks_value)
	$CenterContainer/VBoxContainer/HBoxContainer4/Label2.text = "$ " + str(cash + stocks_value - licence_fee)
	$CenterContainer/VBoxContainer/HBoxContainer3/Label2.text = "$ -" + str(licence_fee)
	$CenterContainer/VBoxContainer/Label.visible_characters = 0
	$CenterContainer/VBoxContainer/HBoxContainer/Label2.visible_characters = 0
	$CenterContainer/VBoxContainer/HBoxContainer2/Label2.visible_characters = 0
	$CenterContainer/VBoxContainer/HBoxContainer4/Label2.visible_characters = 0
	$CenterContainer/VBoxContainer/HBoxContainer3/Label2.visible_characters = 0

func trigger_text():
	set_process(true)

func _process(delta: float) -> void:
	$CenterContainer/VBoxContainer/Label.visible_characters += 1
	$CenterContainer/VBoxContainer/HBoxContainer/Label2.visible_characters += 1
	$CenterContainer/VBoxContainer/HBoxContainer2/Label2.visible_characters += 1
	$CenterContainer/VBoxContainer/HBoxContainer4/Label2.visible_characters += 1
	$CenterContainer/VBoxContainer/HBoxContainer3/Label2.visible_characters += 1


func fail_to_pay():
	$AnimationPlayer.play("overdue_warning")
	await $AnimationPlayer.animation_finished

func clear_payment():
	$AnimationPlayer.play("payed_message")
	await $AnimationPlayer.animation_finished

func fade_in():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	queue_free()
