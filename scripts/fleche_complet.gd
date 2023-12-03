extends Node2D

@export var nbr_points_cape = 35
@export var update_interval = 0.1
@export var cape = preload("res://scenes/cape.tscn")
var points_cape = []
var derniers_vect_pos = []
@onready var ma_var = $fleche

var i_cape = 0

signal fleche_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(nbr_points_cape):
		var child = cape.instantiate()
		$PhysiqueCape.add_child(child)
		points_cape.push_back(child)
		$Visual_cape.add_point($fleche.position)
	$Timer.wait_time = update_interval
	$Timer.start(0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	update_pos()


func update_pos():
	points_cape[i_cape].position = $fleche.position
	$Visual_cape.remove_point(0)
	$Visual_cape.add_point($fleche.position)
	i_cape = (i_cape + 1) % nbr_points_cape


func _on_timer_timeout():
	pass



func _on_fleche_fleche_hit():
	fleche_hit.emit()


func _on_fleche_area_entered(area):
	if area.is_in_group("projectile") or area.is_in_group("ennemi"):
		print("Touché")
		fleche_hit.emit()
