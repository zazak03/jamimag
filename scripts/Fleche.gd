extends Area2D
@export var speed = 200
@export var rot_speed = PI/3 + PI/4
signal  Fleche_hit
@export var nbr_points_cape = 22
@export var ecart_points = 10
@export var cape = preload("res://scenes/cape.tscn")
@onready var depart_cape = $DepCape
var points_cape = []
var derniers_vect_pos = []

# Called when the node enters the scene tree for the first time.
#CLE: instancien nbr_points_cape instances du point de base de la cape
func _ready():
	for i in range(nbr_points_cape):
		depart_cape.add_child(cape.instantiate())
		for child in depart_cape.get_children():
			points_cape.push_back(child)
			derniers_vect_pos.push_back(child.position)
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
	depart_cape.rotation = 0
	update_pos()

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


#CLE: Fonction qui s'occupe de décaler tous les points de la cape
#Pour Tristan : il faut que tu mette DepCape dans la scène principale, de manière à ce qu'elle suive
#la position de fleche mais n'hérite pas de sa rotation 
func update_pos():
	var pos_actuelle = position - depart_cape.position
	decale2(Vector2.ZERO, derniers_vect_pos)
	derniers_vect_pos = derniers_vect_pos.map(func(vector2):return vector2 - position.normalized()*ecart_points)
	for i in range(depart_cape.get_child_count()):
		depart_cape.get_child(i).position = derniers_vect_pos[i]
		



func _on_body_entered(body):
	Fleche_hit.emit()
	$FlecheHitbox.set_deferred("disabled", true)
