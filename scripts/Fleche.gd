extends Area2D
@export var speed = 200
@export var rot_speed = PI/3 + PI/4
var long_fleche = 47 #longueur de la fleche en pixel, moins quelques pixel pour éviter les bugs (requise pour le rebond)
signal  Fleche_hit
signal change_parent_rotation
# Called when the node enters the scene tree for the first time.
#CLE: instancien nbr_points_cape instances du point de base de la cape
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sign_rot = 0
	if Input.is_action_pressed("turn_counterclockwise"):
		sign_rot = -1
	if Input.is_action_pressed("turn_clockwise"):
		sign_rot = 1
	rotation += rot_speed * delta * sign_rot
	var velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += velocity * delta

func _physics_process(_delta):
	pass

#CLE: Insère un élément dans un tableau rempli, le dernier élément finit hors du tableau.
func decale(val, tabl):
	var prec = tabl[0]
	var tampon = 0
	for i in range(1, tabl.length()):
		tampon = prec
		prec = tabl[i]
		tabl[i] = tampon
	tabl[0] = val

#CLE: Supprime la dernière valeur du tableau, rajoute une nouvelle valeur
#Mieux pour un tableau de vec2
func decale2(val, tab):
	tab.push_front(val)
	tab.pop_back()
#ne sait pas si utile
func decale_cercle(tab):
	var tampon = tab[0]
	decale2(tampon, tab)

#Calcule le plus proche voisin du vecteur vector dans le tableau array
func plus_proche(array, vector:Vector2):
	var min = vector.distance_to(array[0])
	var vector_return = array[0]
	for par_vect in array:
		if min > vector.distance_to(par_vect):
			min = vector.distance_to(par_vect)
			vector_return = par_vect
	return vector_return

func convert_map_local(vect, body):
	return get_parent().to_local(body.map_to_local(vect))

func convert_cells_local(array, body:TileMap):
	var array_to_return = []
	for vect in array:
		array_to_return.append(convert_map_local(vect, body))
	return array_to_return



func get_dir_collision(body:TileMap):
	var bout_fleche = get_parent().to_local(position + long_fleche * Vector2.RIGHT.rotated(rotation))
	var map_bout_fleche = body.local_to_map(get_parent().to_local(bout_fleche))
	var surrounding_cells_not_converted = body.get_surrounding_cells(map_bout_fleche)
	var surrounding_cells = convert_cells_local(surrounding_cells_not_converted, body)
	var pos = plus_proche(surrounding_cells, bout_fleche)
	var pos_cell_droite = convert_map_local(body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_RIGHT_SIDE), body)
	var pos_cell_gauche =convert_map_local(body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_LEFT_SIDE), body)
	var pos_cell_haut = convert_map_local(body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_TOP_SIDE), body)
	var pos_cell_bas = convert_map_local(body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE), body)
	if pos == pos_cell_bas and body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE) != body.INVALID_CELL:
		return Vector2.UP
	if pos == pos_cell_haut and body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_TOP_SIDE) != body.INVALID_CELL:
		return Vector2.DOWN
	if pos == pos_cell_droite and body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_RIGHT_SIDE) != body.INVALID_CELL:
		return Vector2.LEFT
	if pos == pos_cell_gauche and body.get_neighbor_cell(map_bout_fleche,TileSet.CELL_NEIGHBOR_LEFT_SIDE) != body.INVALID_CELL:
		return Vector2.RIGHT



func _on_body_entered(body):
	if body.is_in_group("mur"):
		var vect_normal = get_dir_collision(body)
		var vect_bounced = Vector2.RIGHT.rotated(rotation).bounce(vect_normal)
		rotation = vect_bounced.angle()
	if body.is_in_group("projectiles") or body.is_in_group("ennemis"):
		print("Touché !")
		Fleche_hit.emit()
