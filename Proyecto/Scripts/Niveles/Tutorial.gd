extends Control
var enemigosEliminados = 0
@export var maxEnemigos = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemigosEliminados == maxEnemigos:
		get_tree().change_scene_to_file("res://Escenas/Niveles/Level_1.tscn")


func _on_area_2d_body_exited(body):
	if body.is_in_group("Enemigo"):
		enemigosEliminados += 1
		print(enemigosEliminados)
		
