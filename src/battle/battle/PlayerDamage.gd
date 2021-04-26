extends Label

var current_health = 0

func _ready():
	hide()
	State.connect("state_changed", self, "_on_State_changed")
	current_health = State.get_value("current_player_health")

func _on_State_changed(key, value):
	match key:
		"current_player_health":
			var old_health = current_health
			var new_health = value
			current_health = new_health
			var difference = old_health - new_health
			if difference <= 0:
				return
			text = str(difference)
			rect_position = Vector2(59, 95)
			if new_health > 0:
				show()
				$Tween.interpolate_property(self, "rect_position", Vector2(59, 95), Vector2(59, 71), 1.0)
				$Tween.start()
			else:
				show()
				$AnimationPlayer.play("show")

func _on_Tween_tween_completed(object, key):
	hide()

func _on_Battle_paused():
	$Tween.set_active(false)

func _on_Battle_unpaused():
	$Tween.set_active(true)
