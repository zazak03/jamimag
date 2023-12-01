extends Area2D

var speed = 150
var screen_size


func _init():
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
