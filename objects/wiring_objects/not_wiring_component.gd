extends WiringComponent
class_name NotWiringComponent

@export var true_output_value : float = 1.0

var output_on_ready : bool = true
func _ready() -> void:
	super()
	if output_on_ready: output_value = true_output_value

func recieve_input(value : float, from : Wire):
	super(value,from)
	var total_value := get_total_input()
	output_on_ready = false
	if total_value: output_value = 0
	else: output_value = true_output_value
