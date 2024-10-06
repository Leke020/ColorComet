extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Escenas/Niveles/Tutorial.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Escenas/Menus/Musica.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Escenas/Menus/Creditos.tscn")

func _on_quit_pressed():
	get_tree().quit()
