extends Control
var random = RandomNumberGenerator.new()
signal devolverDireccion(dir)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func seleccionarDireccion():
	print("direccion")
	var direccion: Vector2
	match random.randi_range(1, 8):
			1:
				devolverDireccion.emit($Direccion_1.position.angle())
			2:
				devolverDireccion.emit($Direccion_2.position.angle())
			3:
				devolverDireccion.emit($Direccion_3.position.angle())
			4:
				devolverDireccion.emit($Direccion_4.position.angle())
			5:
				devolverDireccion.emit($Direccion_5.position.angle())
			6:
				devolverDireccion.emit($Direccion_6.position.angle())
			7:
				devolverDireccion.emit($Direccion_7.position.angle())
			8:
				devolverDireccion.emit($Direccion_8.position.angle())
		
