extends CanvasLayer


var corazones = 4
var corazonesmax = 4
@onready var player = get_parent().get_node("Player")
@onready var Contorno = $Vida_Contorno
@onready var Relleno = $Vida_Relleno

func _ready():
	if player != null:
		player.cambio_vida.connect(cambio_textura)

func cambio_textura(value):
	corazones = value
	if corazones >= 0:
		if corazones <= corazonesmax:
			Relleno.size.x = corazones * 104
