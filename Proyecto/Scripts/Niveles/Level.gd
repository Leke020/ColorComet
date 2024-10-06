extends Node2D
#@export var maximo_Enemigos = int
var _cantidad_Enemigos 
var _player 
var _enemigo_Detectado
var _position
var _movimiento = Vector2.ZERO
var tiempoMinPorDisparo = 0.01
var tiempoMaxPorDisparo = 0.1
var tiempoHastaSiguienteDisparo = tiempoMaxPorDisparo
var tiempoTranscurridoDesdeDisparo = 0
var random = RandomNumberGenerator.new()
@export var enemigos: Array[PackedScene] = []
@export var maxEnemigos = 0
var _kamikaze = load("res://Escenas/Enemigo/Kamikaze/Enemigo_kamikaze.tscn")
#var _kamikaze = load("res://Escenas/Enemigo/Kamikaze/Enemigo_kamikaze_v_2.tscn")
var enemigosEliminados = 0
var _enemigos
var señal
var puedeMorir = false
var tiempoRestante = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	_player = get_node("Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tiempoFuera(delta)
	#_kamikaze = load("res://Escenas/Enemigo/Kamikaze/Enemigo_kamikaze.tscn")
	if _enemigos != null:
		
		
		pass
	#_kamikaze = load("res://Escenas/Enemigo/Kamikaze/Enemigo_kamikaze_v_2.tscn")
	spawnearEnemigos(delta)
	if enemigosEliminados == maxEnemigos:
		print("Eemigos eliminados")
		get_tree().change_scene_to_file("res://Escenas/Menus/Next_Level_2.tscn")
func _physics_process(delta):
	_movimiento = Vector2.ZERO
	#spawnearEnemigos(delta)
	

func spawnearEnemigos(delta):
	tiempoTranscurridoDesdeDisparo += delta
	if (tiempoTranscurridoDesdeDisparo >= tiempoHastaSiguienteDisparo):
		tiempoTranscurridoDesdeDisparo = 0
		#var instanciarEnemigos = enemigos[0].instantiate()
		var instanciarEnemigos = _kamikaze.instantiate()
		#instanciarEnemigos.encontrarPlayer(_player)
		
		
		
		
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
	#match random.randi_range(0, 1):
		
		
	


func _on_detectar_player_body_entered(body):
	_cantidad_Enemigos = body.name.begins_with("Enemigo")
	if body.name.begins_with("Enemigo"):
		_enemigos = get_tree().get_nodes_in_group("Enemigo")
		
	if body.name.begins_with("Enemigo") && _player != null:
		body.encontrarPlayer(_player)
		
	
func contadorEnemigos():
	enemigosEliminados += 1

func _on_detectar_player_body_exited(body):
	if body.is_in_group("Enemigo"):
		#enemigosEliminados += 1
		print(enemigosEliminados)

	
func tiempoFuera(delta):
	print("delta = ", delta)
	tiempoRestante += delta
	if(tiempoRestante >= 20):
		get_tree().change_scene_to_file("res://Escenas/Menus/Next_Level_2.tscn")





func _on_area_de_muerte_body_entered(body):
	if body.is_in_group("Enemigo"):
		puedeMorir = true
