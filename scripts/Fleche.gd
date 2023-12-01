extends Node2D
var speed = 400
var rot_speed = PI/3 + PI/4

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
	var velocity = Vector2.RIGHT.rotated(rotation) * speed
	position += velocity * delta


	
