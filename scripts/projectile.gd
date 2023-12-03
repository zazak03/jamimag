extends Area2D

var speed = 100
var screen_size

signal bullet_destroyed
signal bullet_ricochet
var act_rebond = true


func _init():
	pass
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _on_body_entered(body):
	if body.is_in_group("mur"):
		bullet_destroyed.emit()
		queue_free()



func _on_area_entered(area):
	if area.is_in_group("cape"):
		if act_rebond:
			rotation = PI + rotation
			$DesactCollisionRebond.start()
			act_rebond = false
			bullet_ricochet.emit()


func _on_desact_collision_rebond_timeout():
	act_rebond = true
