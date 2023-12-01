extends RigidBody2D

var direction
var speed
var screen_size

func test():
	var test = Vector2(1,3)
	var speed = 25
	position.x = 500
	position.y = 200
	init(test, speed)

func _init():
	test()

	
func init(vect, speedd):
	##Input:
	## vect : le vecteur direction de la balle (normalisé)
	## speed : direction de la balle en radian
	direction = vect
	speed = speedd
	#vecteur de référence : utile pour avoir l'orientation
	var vect_ref = Vector2(0, -1)
	rotation =  - direction.angle_to(vect_ref)
	print(direction.angle_to(vect_ref))
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction.length() > 0:
		direction = direction.normalized() * speed
	position += direction * delta
	position = position.clamp(Vector2.ZERO, screen_size)
