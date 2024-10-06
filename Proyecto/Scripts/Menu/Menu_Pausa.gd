extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("Pausa") && $Popup.visible == false):
		print("pausa")
		get_tree().paused = true
		$Popup.visible = true


func _on_boton_reanudar_pressed():
	print("reaundar")
	get_tree().paused = false
	$Popup.visible = false


func _on_boton_menu_principal_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Escenas/Menus/Main_Menu.tscn")
