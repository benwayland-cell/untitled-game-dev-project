extends WiringComponent
class_name PrintWiringComponent

func recieve_input(value : float, from : Node):
	super(value,from)
	var total_value := get_total_input()
	print(total_value, ":", from)
