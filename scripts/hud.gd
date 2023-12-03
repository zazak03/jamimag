extends CanvasLayer

@export var next:PackedScene

@export var level = 0

signal start_game

func _ready():
	$LevelLabel.text = str(level)
	$RetryButton.hide()
	$NextLevelButton.hide()
	$ScoreLabel.text = "Score :"

func show_message(text):
	$LevelLabel.text = str(level)
	$TitleLabel.text = text
	$TitleLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	$RetryButton.show()

func show_w():
	show_message("You won !")
	$NextLevelButton.show()


func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_mul(mul):
	if mul != 0 :
		#$MulLabel.show()
		$MulLabel.text = "x" + str(mul)
	else :
		$MulLabel.hide()

func update_kills(kills):
	$KillsLabel.text = "Kills: " + str(kills)


func _on_start_button_pressed():
	$StartButton.hide()
	$TitleLabel.hide()
	start_game.emit()


func _on_cible_cible_atteinte():
	show_w()


func _on_fleche_complet_fleche_hit():
	show_game_over()


func _on_retry_button_pressed():
	get_tree().reload_current_scene()


func _on_next_level_button_pressed():
	get_tree().change_scene_to_packed(next)


func _on_template_scene_updatehud(score, mul, kills):
	update_score(score)
	update_mul(mul)
	update_kills(kills)
