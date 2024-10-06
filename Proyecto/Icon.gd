extends Sprite2D
func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

   # Print the size of the viewport.
	print("Viewport Resolution is: ", get_viewport_rect().size)
func _physics_process(delta):
	lookAtMouse()
	
func lookAtMouse():
	var mousePos = get_global_mouse_position()
	get_node("Pivot").look_at(mousePos)
	
