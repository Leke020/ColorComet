extends Node2D
#@export var _bala: Array[PackedScene] = []
var _bala = preload("res://Escenas/Elemenos/Bala.tscn")
var _instanciar_Bala
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
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
	if position.x >= 1225:
		position.x = -79
	elif position.x <= -79:
		position.x = 1225
	
func reubicar_vertical():
	if position.y >= 725:
		position.y = -75
	elif position.y <= -75:
		position.y = 725
		
func disparar():
	if Input.is_action_just_pressed("Disparar"):
		print("disparar")
		_instanciar_Bala = _bala.instantiate()
		var direction = get_local_mouse_position().angle()
		
		get_parent().add_child(_instanciar_Bala)
		_instanciar_Bala.inicio(global_position, direction, "Enemigo")
		
	
func hayBala() -> bool:
	return(_instanciar_Bala != null)
