extends Node2D

var kills = 0
var score = 0
var mul = 0
@export var score_temporel_max = 1000
@export var deincrement_ratio = 100
@export var points_par_proj = 100
@export var bullet_scene: PackedScene
@onready var score_temporel = score_temporel_max

signal updatehud(score, mul, kills)

func _ready():
	get_tree().paused = true
	var children = get_children()
	for child in children:
		if child.is_in_group("projectile"):
			child.queue_free()
	$BulletTimer.start()
	$ScoreTimer.start()

func _process(delta):
	emit_signal("updatehud", score, mul, kills)

func _on_deincrement_timer_timeout():
	score_temporel = clamp(score_temporel - deincrement_ratio, 0, 1000)

func _on_bullet_ricochet():
	if mul == 0 :
		mul = 1
	mul += 1

func _on_bullet_destroyed():
	score += mul * 100
	mul = 0

func _on_cible_cible_atteinte():
	if mul != 0:
		score = score + score_temporel*mul
	else :
		score = score + score_temporel
	get_tree().paused = true


func _on_fleche_complet_fleche_hit():
	get_tree().paused = true


func _on_canvas_layer_start_game():
	get_tree().paused = false




func _on_ennemy_follow_ennemy_hit():
	var children = get_children()
	for child in children:
		if child is Path2D:
			var enfant_denfant = child.get_children()
			for enfant in enfant_denfant:
				if enfant.is_in_group("ennemis"):
					child.get_child(0).vitesse_de_tire -= 0.5
					child.get_child(0).vitesse += 20







func _on_bullet_timer_timeout():
	$BulletTimer.start()
	var bullet = bullet_scene.instantiate()
	var bull_spawn_location = get_node("BulletPath/BulletSpawnLocation")
	bull_spawn_location.progress_ratio = randf()
	var direction = bull_spawn_location.rotation + PI/2
	direction += randf_range(-PI/4, PI/4)
	bullet.rotation = direction
	bullet.position = bull_spawn_location.position
	bullet.speed = randf_range(250.0, 350.0)
	add_child(bullet)
