extends TileMap



var particulas = preload("res://scene/block_particles.tscn")

var bloco_grama = 1
var bloco_terra = 0

func _input(event):
	if event is InputEventMouseButton:
		var mouse_pos = get_global_mouse_position()
		if event.button_index == BUTTON_LEFT and event.pressed:
			Tirar_blocos(mouse_pos)
			
		if event.button_index == BUTTON_RIGHT and event.pressed:
			Colocar_blocos(mouse_pos,2)

func Tirar_blocos(mouse):
	if !Bloco_nulo():
		var cell = Vector2(int(world_to_map(mouse).x),int(world_to_map(mouse).y))
		if get_cellv(Vector2(cell.x,cell.y-1)) == 7:
			set_cell(cell.x,cell.y-1,-1)
		set_cell(cell.x,cell.y,-1)

		Particulas_bloco(map_to_world(world_to_map(mouse)))

	pass			

func Colocar_blocos(mouse,bloco):
	if Bloco_nulo() and map_to_world(world_to_map(mouse)).y < 0 :
		set_cell(int(world_to_map(mouse).x),int(world_to_map(mouse).y),bloco)

		#print(world_to_map(mouse).x,world_to_map(mouse).y)
	pass

func Particulas_bloco(pos):
	var instance = particulas.instance()
	instance.emitting = true
	instance.global_position = pos+cell_size/2
	add_child(instance)
	pass

func Bloco_nulo():
	if get_cellv(world_to_map(get_global_mouse_position())) == -1:
		return true
	else:
		return false


func _on_Timer_timeout():
	crescer_grama()
	morrer_grama()
	pass

func crescer_grama():# cada terra próxima de uma grama tem a possibilidade de virar uma grama
	
	for cell in get_used_cells_by_id(bloco_terra):
		if get_cell(cell.x,cell.y-1) == -1 and get_cell(cell.x +rand_range(-2,2),cell.y +rand_range(-4,3)) == bloco_grama and rand_range(0,3) <= 1:
			set_cell(cell.x,cell.y,bloco_grama)

				
func morrer_grama(): #cada grama sem fonte de luz tem a possibilidade de virar uma terra
	for cell in get_used_cells_by_id(bloco_grama):
		if get_cell(cell.x,cell.y-1) != -1 and get_cell(cell.x,cell.y-1) != 7 and rand_range(0,40)<=1:
			set_cell(cell.x,cell.y,bloco_terra)



