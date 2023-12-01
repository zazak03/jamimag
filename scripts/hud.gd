extends CanvasLayer

signal start_game

func show_message(text):
	$TitleLabel.text = text
	$TitleLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$TitleLabel.text = "Name of the game"
	$TitleLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = "Score :" + str(score)

func update_level(level):
	$LevelLabel.text = "Score :" + str(level)

func _on_start_button_pressed():
	print("start pressed")
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$TitleLabel.hide()
