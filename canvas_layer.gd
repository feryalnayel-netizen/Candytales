extends CanvasLayer


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('character'):
		self.show()

func _on_restart_pressed() -> void:
	self.hide()
	
