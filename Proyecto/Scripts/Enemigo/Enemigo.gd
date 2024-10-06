extends CharacterBody2D
var _movimiento = Vector2.ZERO
#@export var _player = Node
var _tiempo_De_Espera = 20
var _bala = preload("res://Escenas/Elemenos/Bala.tscn")
var _player
var tiempoMinPorDisparo = 1.0
var tiempoMaxPorDisparo = 2.0
var tiempoHastaSiguienteDisparo = tiempoMaxPorDisparo
var tiempoTranscurridoDesdeDisparo = 0
var speed = 170
var vida = 30
var dañoEmitido = 1
var barraDeVida 
@export var puedeDisparar = true
@export var puedeMover = true
@onready var audio_enemy = $Disparoenemigo

func _ready():
	pass

func _physics_process(delta):
	Seguir_Player()
	disparar(delta)
	
	
func Seguir_Player():
	if _player != null && puedeMover == true:
		get_node("Pivot").look_at(_player.position)
		velocity = position.direction_to(_player.position) * speed
	move_and_slide()
	pass

func recibirDaño(dañoRecibido):
	vida -= dañoRecibido
	print(vida)
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	if vida <= 0:
		death()

func death():
	queue_free()

func disparar(delta):
	tiempoTranscurridoDesdeDisparo += delta
	if (tiempoTranscurridoDesdeDisparo >= tiempoHastaSiguienteDisparo && puedeDisparar == true):
		print("disparar")
		tiempoTranscurridoDesdeDisparo = 0
		var _instanciar_Bala = _bala.instantiate()
		var direction = (_player.position - global_position).angle() 
		get_parent().add_child(_instanciar_Bala)
		_instanciar_Bala.daño = dañoEmitido
		_instanciar_Bala.inicio(global_position, direction * 1, "Player")
		audio_enemy.play()
	
func encontrarPlayer(player):
	_player = player
