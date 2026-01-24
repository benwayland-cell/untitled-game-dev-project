extends WiringComponent
class_name NodeWiringComponent

func recieve_input(value : float, from : Wire):
	super(value,from)
	output_value = get_total_input()
