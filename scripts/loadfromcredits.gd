extends Node2D


@export var worstlevel:PackedScene
@export var modesurvie:PackedScene

func _on_worst_pressed():
	get_tree().change_scene_to_packed(worstlevel)


func _on_survival_pressed():
	get_tree().change_scene_to_packed(modesurvie)
