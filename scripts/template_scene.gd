extends Node2D

var score = 0
var mul = 0
@export var score_temporel = 1000
@export var deincrement_ratio = 100
@export var points_par_proj = 100

func _ready():
	$DeincrementTimer.start(0)




func _on_deincrement_timer_timeout():
	score_temporel -= deincrement_ratio

func _on_bullet_ricochet():
	mul += 1

func _on_bullet_destroyed():
	score += mul * 100
	mul = 0

func _on_cible_cible_atteinte():
	if mul != 0:
		score = score + score_temporel*mul
	else :
		score = score + score_temporel
	print(score)
