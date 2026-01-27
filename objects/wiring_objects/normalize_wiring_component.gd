extends WiringComponent
class_name NormalizeWiringComponent

func recieve_input(value : float, from : Wire):
	super(value,from)
	var total_value := get_total_input()
	output_value = 1 if (total_value > 0) else (-1 if (total_value < 0) else 0)
