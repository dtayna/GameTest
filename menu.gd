extends Control

signal pressed(button)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in get_tree().get_nodes_in_group("botoes"):
		button.pressed.connect(_on_button_pressed.bind(button))
		
func _on_button_pressed(button: Button) -> void:
	match button.name:
		"Button":
			get_tree().change_scene_to_file("res://level_1.tscn")
		"Button2":
			get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.

