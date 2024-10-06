extends Node2D

var celeracion = 500
var vel: Vector2
var _objetivo
var daño
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Icon.modulate = "white"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += vel * delta
	eliminar()

func inicio(pos, dir, obj) -> void:
	position = pos
	rotation = dir
	_objetivo = obj
	vel = Vector2(celeracion, 0).rotated(dir)


func _on_hit_box_body_entered(body):
	if (body.is_in_group("Enemigo") && _objetivo == "Enemigo"):
		
		body.recibirDaño(daño)
		queue_free()
	if (body.name == "Player" && _objetivo == "Player"):
		print("toque Player")
		body.recibirDaño(daño)
		queue_free()
	
func _on_hit_box_area_entered(area):
	if (area.is_in_group("Enemigo") && _objetivo == "Enemigo"):
		
		area.recibirDaño(daño)
		queue_free()

func eliminar():
	if position.x >= 1400:
		queue_free()
	elif position.x <= -43:
		queue_free()
	if position.y >= 725:
		queue_free()
	elif position.y <= -75:
		queue_free()




