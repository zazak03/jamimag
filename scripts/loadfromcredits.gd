extends Node2D


var worstlevel:PackedScene
var modesurvie:PackedScene


func _ready():
	worstlevel = preload("res://levels/level_five_ancien.tscn")
	modesurvie = preload("res://levels/survival_mode.tscn")


func _on_worst_pressed():
	get_tree().change_scene_to_packed(worstlevel)


func _on_survival_pressed():
	get_tree().change_scene_to_packed(modesurvie)
