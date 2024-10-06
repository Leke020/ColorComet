extends CharacterBody2D
var tiempoMinPorDisparo = 1.0
var tiempoMaxPorDisparo = 0.3
var tiempoHastaSiguienteDisparo = tiempoMaxPorDisparo
var tiempoTranscurridoDesdeDisparo = 0

const max_speed = 400
const accel = 1500
const friction = 300

var input = Vector2.ZERO
#@export var _bala: Array[PackedScene] = []
var _bala = preload("res://Escenas/Elemenos/Bala_player.tscn")
var _instanciar_Bala
var dañoEmitido = 10
signal Damage
signal cambio_vida(value)
@export var Salud: int = 4

@onready var audio_player = $Disparo

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
	
	
func _physics_process(delta):
	lookAtMouse()
	MovimientoWASD(delta)
	reubicar_horizontal()
	reubicar_vertical()
	disparar(delta)

func lookAtMouse():
	var mousePos = get_global_mouse_position()
	get_node("Pivot").look_at(mousePos)
	
func get_input():
	input.x = int(Input.is_action_pressed("Derecha")) - int(Input.is_action_pressed("Izquierda"))
	input.y = int(Input.is_action_pressed("Abajo")) - int(Input.is_action_pressed("Arriba"))
	return input.normalized()

func MovimientoWASD(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
		
func reubicar_horizontal():
	if position.x >= 1183:
		position.x = -21
	elif position.x <= -21:
		position.x = 1183
	
func reubicar_vertical():
	if position.y >= 668:
		position.y = -18
	elif position.y <= -18:
		position.y = 668
		
func disparar(delta):
	tiempoTranscurridoDesdeDisparo += delta
	if Input.is_action_pressed("Disparar") && tiempoTranscurridoDesdeDisparo >= tiempoHastaSiguienteDisparo:
		tiempoTranscurridoDesdeDisparo = 0
		_instanciar_Bala = _bala.instantiate()
		var direction = get_local_mouse_position().angle()
		
		get_parent().add_child(_instanciar_Bala)
		_instanciar_Bala.daño = dañoEmitido
		_instanciar_Bala.inicio(global_position, direction, "Enemigo")
		audio_player.play()
		
	
func recibirDaño(dañoRecibido):
	Salud -= dañoRecibido
	Damage.emit()
	emit_signal("cambio_vida", Salud)
	print("vida Player = ", Salud)
	if Salud <= 0:
		death()
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	
func death():
	get_tree().change_scene_to_file("res://Escenas/Elemenos/Perdiste.tscn")
	

func hayBala() -> bool:
	return(_instanciar_Bala != null)
