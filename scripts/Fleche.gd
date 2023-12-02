extends Area2D
@export var speed = 200
@export var rot_speed = PI/3 + PI/4
signal  Fleche_hit

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
	for par_vect in array:
		if min > vector.distance_to(par_vect):
			min = vector.distance_to(par_vect)
	return min

	

func _on_body_entered(body):
	if body.is_in_group("mur"):
		var surrounding_cells = body.get_surrounding_cells(position)
		var pos = plus_proche(surrounding_cells, position)
		var vector =  Vector2.ZERO
		if pos == body.get_neighbor_cell(pos, 0) or pos == body.get_neighbor_cell(pos, 8):
			vector = Vector2.DOWN
		if pos == body.get_neighbor_cell(pos, 4) or pos == body.get_neighbor_cell(pos, 12):
			vector= Vector2.RIGHT
		var vector_bounced = position.bounce(vector)
		rotation = vector_bounced.angle()
	if body.is_in_group("projectiles") or body.is_in_group("ennemis"):
		print("Touché !")
		Fleche_hit.emit()
