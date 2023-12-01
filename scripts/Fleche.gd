extends Node2D
signal fleche_hit
signal cible_touched
var speed = 400
var rot_speed = PI/3 + PI/4
var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sign_rot = 0
	if Input.is_action_pressed("turn_counterclockwise"):
		sign_rot = -1
	if Input.is_action_pressed("turn_clockwise"):
		sign_rot = 1
	rotation += rot_speed * delta * sign_rot
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += velocity * delta


	


func _on_area_2d_body_entered(body):
	if body is TileMap: #on va peut être devoir changer
		var vector = Vector2.RIGHT
		velocity.reflect(vector) #Provisoire, le temps de savoir comment calculer vecteur tangeant
	elif body.get_name() == "Cible": #a changer aussi
		cible_touched.emit()
	else:
		fleche_hit.emit()
