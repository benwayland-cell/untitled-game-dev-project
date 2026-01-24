extends WiringComponent
class_name ButtonWiringComponent

@export var power_output_value : float = 1.0

var detected_bodies : int = 0

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if detected_bodies == 0: output_value = power_output_value
	detected_bodies += 1


func _on_area_2d_body_exited(_body: Node2D) -> void:
	detected_bodies -= 1
	if detected_bodies == 0: output_value = 0
