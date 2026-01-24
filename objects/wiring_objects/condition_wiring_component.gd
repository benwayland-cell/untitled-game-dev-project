extends WiringComponent
class_name ConditionWiringComponent

@export var comparison_value : float = 2.0
@export_enum("greater","greater_equal","equal","less_equal","less") var condition = "greater_equal"
@export var override_output_value : float = 0.0

func recieve_input(value : float, from : Wire):
	super(value,from)
	var total_value = get_total_input()
	match condition:
		"greater":
			if total_value > comparison_value: 
				prep_output(total_value)
				return
		"greater_equal":
			if total_value >= comparison_value: 
				prep_output(total_value)
				return
		"equal":
			if total_value == comparison_value: 
				prep_output(total_value)
				return
		"less_equal":
			if total_value <= comparison_value: 
				prep_output(total_value)
				return
		"less":
			if total_value < comparison_value: 
				prep_output(total_value)
				return
	output_value = 0.0

func prep_output(total_value : float):
	if override_output_value: output_value = override_output_value
	else: output_value = total_value
