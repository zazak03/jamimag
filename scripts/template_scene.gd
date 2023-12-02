extends Node2D

var kills = 0
var score = 0
var mul = 0
@export var score_temporel_max = 1000
@export var deincrement_ratio = 100
@export var points_par_proj = 100

@onready var score_temporel = score_temporel_max

signal updatehud(score, mul, kills)

func _ready():
	get_tree().paused = true

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
			child.get_child(0).vitesse_de_tire -= 0.5
			child.get_child(0).vitesse_de_tire += 20
