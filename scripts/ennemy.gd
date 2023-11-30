extends Node2D

var target

var bullet_scene = preload("res://scenes/example.tscn")

func tirer():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = $ennemy_oriantation/bullet_start.global_position
	bullet_instance.global_rotation = $ennemy_oriantation.global_rotation
	add_child(bullet_instance)
	



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0
	$ennemy_oriantation.rotate(get_angle_to(target.global_position))


func _on_timer_timeout():
	tirer()
