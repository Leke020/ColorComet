extends Node2D

var celeracion = 500
var vel: Vector2
var _objetivo
var daño = 1
var random = RandomNumberGenerator.new()
var _player
var vida = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Icon.modulate = "white"
	seleccionarDireccion()
	#$Direcciones2.seleccionarDireccion()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += vel * delta
	eliminar()

func inicio(dir) -> void:
	rotation = dir
	vel = Vector2(celeracion, 0).rotated(dir)
	
func seleccionarDireccion():
	print("direccion")
	match random.randi_range(1, 8):
			1:
				inicio($Direcciones/Direccion_1.position.angle())
				
				print(1)
			2:
				inicio($Direcciones/Direccion_2.position.angle())
				
				print(2)
			3:
				inicio($Direcciones/Direccion_3.position.angle())
				
				print(3)
			4:
				inicio($Direcciones/Direccion_4.position.angle())
				
				print(4)
			5:
				#inicio($Direcciones/Direccion_5.position.angle())
				
				print(5)
			6:
				inicio($Direcciones/Direccion_6.position.angle())
				
				print(6)
			7:
				inicio($Direcciones/Direccion_7.position.angle())
				
				print(7)
			8:
				inicio($Direcciones/Direccion_8.position.angle())
				
				print(8)
	
func _on_hurt_box_body_entered(body):
	if body.name == "Player":
		print("toque Player")
		body.recibirDaño(daño)
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

func recibirDaño(dañoRecibido):
	vida -= dañoRecibido
	print(vida)
	if vida <= 0:
		death()
		
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	

func death():
	
	queue_free()


func encontrarPlayer(player):
	_player = player

func _on_direcciones_2_devolver_direccion(dir):
	inicio(dir)
	pass # Replace with function body.
