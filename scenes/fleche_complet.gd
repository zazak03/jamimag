extends Node2D
var long_cape = 200
@export var scene_bout_de_cape : PackedScene
var table_bout_cape = []

func decale(val, tabl):
	var prec = tabl[0]
	var tampon = 0
	for i in range(1, len(tabl)):
		tampon = prec
		prec = tabl[i]
		tabl[i] = tampon
	tabl[0] = val

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(long_cape/10):
		table_bout_cape.append(scene_bout_de_cape.instantiate())
		table_bout_cape[i].position = $fleche.position + (30+10*i)*Vector2.LEFT
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var long = 0
	for i in range(len(table_bout_cape)-1):
		long += table_bout_cape[i].position.distance_to(table_bout_cape[i+1].position)
	var new_bout = scene_bout_de_cape.instantiate()
	decale(new_bout, table_bout_cape)
	
