extends PathFollow2D
signal ennemy_hit
@export var vitesse:float = 100
@export var target:Node
@export var vitesse_de_tire:float = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$ennemy.target = target
	$ennemy/Timer.wait_time = vitesse_de_tire
	$ennemy/Timer.start(0)
	$ennemy.global_rotation = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta*vitesse



func _on_ennemy_area_entered(area):
	if area.is_in_group("projectile"):
		ennemy_hit.emit()
		queue_free()
