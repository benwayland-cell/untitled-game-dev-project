extends WiringComponent
class_name DelayWiringComponent

@export var delay_time = 1.0

func recieve_input(value : float, from : Wire):
	super(value,from)
	var total_value := get_total_input()
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.start(delay_time)
	await timer.timeout
	output_value = total_value
