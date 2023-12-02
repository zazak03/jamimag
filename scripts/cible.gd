extends Area2D

signal cible_atteinte

func _on_area_entered(area):
	if area.is_in_group("fleche"):
		cible_atteinte.emit()
