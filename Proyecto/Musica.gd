extends Control

var master_bus = AudioServer.get_bus_index("Master")
var SFX_bus = AudioServer.get_bus_index("SFX")

func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(master_bus,true)
	else: 
		AudioServer.set_bus_mute(master_bus, false) 








func _on_h_slider_effect_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(SFX_bus,true)
	else: 
		AudioServer.set_bus_mute(SFX_bus, false) 



func _on_volver_pressed():
	get_tree().change_scene_to_file("res://Escenas/Menus/Main_Menu.tscn")
