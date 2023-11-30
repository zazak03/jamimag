extends Node2D

var target

var bullet_scene = preload("res://scenes/example.tscn")

func tirer():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = $bullet_start.global_position
	bullet_instance.global_rotation = global_rotation
	add_child(bullet_instance)
	



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate(get_angle_to(target.global_position))
	print(get_angle_to(target.global_position))
	pass


func _on_timer_timeout():
	tirer()
