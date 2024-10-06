extends CharacterBody2D
var _movimiento = Vector2.ZERO
var vel: Vector2
var celeracion = 500
var _player
var _positionPlayer
var _positionPlayerAngle
var speed = 250
var vida = 10
var dañoEmitido = 1
@export var puedeAtacar = true
@export var puedeMover = true
@onready var audio_Enemy = $Explosion
var random = RandomNumberGenerator.new()



signal eliminado

func _ready():
	#$Icon.modulate = "white"
	seleccionarDireccion()
	#$Direcciones2.seleccionarDireccion()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if puedeMover == true:
		position += vel * delta
	#eliminar()
	
func _physics_process(delta):
	#Seguir_Player()
	pass
	
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

func seguir_direccion(direccion, angulo):
	if _player != null && puedeMover == true:
		get_node("Pivot").look_at(direccion)
		#velocity = position.direction_to(direccion) * speed
		#velocity = Vector2(speed,0).rotated(angulo)
		
	move_and_slide()

func Seguir_Player():
	if _player != null && puedeMover == true:
		get_node("Pivot").look_at(_player.position)
		velocity = position.direction_to(_player.position) * speed
		
	#_movimiento = position.direction_to(_player.position)
	
	move_and_slide()
	

func recibirDaño(dañoRecibido):
	vida -= dañoRecibido
	print(vida)
	if vida <= 0:
		death()
		
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	

func death():
	emit_signal("eliminado")
	queue_free()

func encontrarPlayer(player):
	_player = player


func _on_hurt_box_body_entered(body):
	if body.name == "Player":
		print("Choque player")
		body.recibirDaño(dañoEmitido)
		death()
		


func _on_hurt_box_area_entered(area):
	if area.name == "Player" && puedeAtacar == true:
		print("Choque player")
		area.recibirDaño(dañoEmitido)
		death()



