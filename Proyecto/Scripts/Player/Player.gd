extends CharacterBody2D


#@export var _bala: Array[PackedScene] = []
var _bala = preload("res://Escenas/Elemenos/Bala.tscn")
var _instanciar_Bala
var dañoEmitido = 10
var vida = 100
var barraDeVida
signal Damage
@onready var audio_player = $Disparo
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	barraDeVida = $Life_Bar/TextureProgressBar.value
	
	
func _physics_process(delta):
	lookAtMouse()
	MovimientoWASD()
	reubicar_horizontal()
	reubicar_vertical()
	disparar()

func lookAtMouse():
	var mousePos = get_global_mouse_position()
	get_node("Pivot").look_at(mousePos)
	
func MovimientoWASD():
	if Input.is_action_pressed("Abajo"):
		position.y += 10
	if Input.is_action_pressed("Arriba"):
		position.y -= 10
	if Input.is_action_pressed("Derecha"):
		position.x += 10
	if Input.is_action_pressed("Izquierda"):
		position.x -= 10
		
func reubicar_horizontal():
	if position.x >= 1400:
		position.x = -43
	elif position.x <= -43:
		position.x = 1400
	
func reubicar_vertical():
	if position.y >= 725:
		position.y = -75
	elif position.y <= -75:
		position.y = 725
		
func disparar():
	if Input.is_action_just_pressed("Disparar"):
		
		_instanciar_Bala = _bala.instantiate()
		var direction = get_local_mouse_position().angle()
		
		get_parent().add_child(_instanciar_Bala)
		_instanciar_Bala.daño = dañoEmitido
		_instanciar_Bala.inicio(global_position, direction, "Enemigo")
		audio_player.play()
		
	
func recibirDaño(dañoRecibido):
	vida -= dañoRecibido
	barraDeVida -= dañoRecibido
	Damage.emit()
	print("vida Player = ", vida)
	if vida <= 0:
		death()
	$Pivot/Icon.modulate = "red"
	await get_tree().create_timer(0.3).timeout
	$Pivot/Icon.modulate = "ffffff"
	
func death():
	get_tree().change_scene_to_file("res://Escenas/Elemenos/Perdiste.tscn")
	

func hayBala() -> bool:
	return(_instanciar_Bala != null)
