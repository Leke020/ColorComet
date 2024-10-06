extends Node2D
#@export var maximo_Enemigos = int
var _cantidad_Enemigos 
var _player 
var _enemigo_Detectado
var _position
var _movimiento = Vector2.ZERO
var tiempoMinPorDisparo = 1.0
var tiempoMaxPorDisparo = 0.8
var tiempoHastaSiguienteDisparo = tiempoMaxPorDisparo
var tiempoTranscurridoDesdeDisparo = 0
var random = RandomNumberGenerator.new()
@export var enemigos: Array[PackedScene] = []
@export var maxEnemigos = 0

var enemigosEliminados = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if enemigosEliminados == maxEnemigos:
	#	get_tree().change_scene_to_file("res://Escenas/Menus/Main_Menu.tscn")
	pass
func _physics_process(delta):
	_movimiento = Vector2.ZERO
	spawnearEnemigos(delta)
	

func spawnearEnemigos(delta):
	tiempoTranscurridoDesdeDisparo += delta
	if (tiempoTranscurridoDesdeDisparo >= tiempoHastaSiguienteDisparo):
		tiempoTranscurridoDesdeDisparo = 0
		var instanciarEnemigos = enemigos[random.randi_range(0, 1)].instantiate()
		instanciarEnemigos.encontrarPlayer(_player)
		match random.randi_range(1, 8):
			1:
				instanciarEnemigos.global_position = get_node("SpawnPoint").get_global_position()
			2:
				instanciarEnemigos.global_position = get_node("SpawnPoint2").get_global_position()
			3:
				instanciarEnemigos.global_position = get_node("SpawnPoint3").get_global_position()
			4:
				instanciarEnemigos.global_position = get_node("SpawnPoint4").get_global_position()
			5:
				instanciarEnemigos.global_position = get_node("SpawnPoint5").get_global_position()
			6:
				instanciarEnemigos.global_position = get_node("SpawnPoint6").get_global_position()
			7:
				instanciarEnemigos.global_position = get_node("SpawnPoint7").get_global_position()
			8:
				instanciarEnemigos.global_position = get_node("SpawnPoint8").get_global_position()
		add_child(instanciarEnemigos)
	


func _on_detectar_player_body_entered(body):
	_cantidad_Enemigos = body.name.begins_with("Enemigo")
	if body.name.begins_with("Enemigo") && _player != null:
		body.encontrarPlayer(_player)
	


func _on_detectar_player_body_exited(body):
	if body.name == "Enemigo_Jefe" && _player.Salud > 0:
		print("no hay jefe")
		get_tree().change_scene_to_file("res://Escenas/Elemenos/Ganaste.tscn")
		
