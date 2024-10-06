extends CharacterBody2D
var _movimiento = Vector2.ZERO
#@export var _player = Node
var _tiempo_De_Espera = 20
var _bala = preload("res://Escenas/Elemenos/Bala.tscn")
var _player
var _seguir = false
var tiempoMinPorDisparo = 0.01
var tiempoMaxPorDisparo = 0.1
var tiempoHastaSiguienteDisparo = tiempoMaxPorDisparo
var tiempoTranscurridoDesdeDisparo = 0
var speed = 50
var velocidad_rotacion = 0.02
var vida = 500
var dañoEmitido = 1
var barraDeVida 
var random = RandomNumberGenerator.new()
@export var puedeDisparar = true
@export var posiciones: Array[Node] = []
@onready var audio_enemy = $Disparoenemigo

func _ready():
	print($Pos_1.position)
	
func _physics_process(delta):
	Seguir_Player()
	#comportamiento()
	disparar(delta)
	rotar()
	move_and_slide()

func mover():
	#while(get_parent().position == get_node("Pos_1").position):
	#velocity = position.direction_to($Pos_1.position) * speed 
	velocity = position.direction_to(posiciones[0].position) * speed 
	move_and_slide()
	

func Seguir_Player():
	if (_player != null && _seguir == true):
		#get_node("Pivot").look_at(_player.position)
		velocity = position.direction_to(_player.position) * speed
	
	pass

func recibirDaño(dañoRecibido):
	
	vida -= dañoRecibido
	comportamiento()
	print(vida)
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	
	if vida <= 0:
		death()

func comportamiento():
	if vida == 250:
		print("perdiovida")
		velocidad_rotacion *= -2
		tiempoMaxPorDisparo = 0.3
	if vida == 150:
		print("perdiovida")
		velocidad_rotacion *= -2.5
		tiempoMaxPorDisparo = 0.1
		_seguir = true
			

func death():
	queue_free()

func rotar():
	rotation += velocidad_rotacion

func disparar(delta):
	tiempoTranscurridoDesdeDisparo += delta
	if (tiempoTranscurridoDesdeDisparo >= tiempoHastaSiguienteDisparo && puedeDisparar == true):
		
		tiempoTranscurridoDesdeDisparo = 0
		var _instanciar_Bala = _bala.instantiate()
		var direction
		get_parent().add_child(_instanciar_Bala)
		_instanciar_Bala.daño = dañoEmitido
		audio_enemy.play()
		
		match random.randi_range(1, 4):
			1:
				direction = (get_node("Direccion_1").global_position - global_position).angle()
				_instanciar_Bala.inicio(global_position, direction, "Player")
				_instanciar_Bala.global_position = get_node("Cañon_1").get_global_position()
			2:
				direction = (get_node("Direccion_2").global_position - global_position).angle()
				_instanciar_Bala.inicio(global_position, direction, "Player")
				_instanciar_Bala.global_position = get_node("Cañon_2").get_global_position()
			3:
				direction = (get_node("Direccion_3").global_position - global_position).angle()
				_instanciar_Bala.inicio(global_position, direction, "Player")
				_instanciar_Bala.global_position = get_node("Cañon_3").get_global_position()
			4:
				direction = (get_node("Direccion_4").global_position - global_position).angle()
				_instanciar_Bala.inicio(global_position, direction, "Player")
				_instanciar_Bala.global_position = get_node("Cañon_4").get_global_position()
		
		
		
func encontrarPlayer(player):
	_player = player





func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.recibirDaño(10)
