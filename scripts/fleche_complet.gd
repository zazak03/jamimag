extends Node2D

@export var nbr_points_cape = 35
@export var update_interval = 0.1
@export var cape = preload("res://scenes/cape.tscn")
var points_cape = []
var derniers_vect_pos = []
@onready var ma_var = $fleche

signal fleche_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(nbr_points_cape):
		$DepCape.add_child(cape.instantiate())
	for child in $DepCape.get_children():
		points_cape.push_back(child)
	$Timer.wait_time = update_interval
	$Timer.start(0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass


func update_pos():
	points_cape.push_front(points_cape.pop_back())
	points_cape[1].position = $fleche.position


func _on_timer_timeout():
	update_pos()



func _on_fleche_fleche_hit():
	fleche_hit.emit()


func _on_fleche_area_entered(area):
	if area.is_in_group("projectile"):
		print("Touché")
		fleche_hit.emit()
