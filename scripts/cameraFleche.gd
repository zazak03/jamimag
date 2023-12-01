extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = $"../Fleche".position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0
