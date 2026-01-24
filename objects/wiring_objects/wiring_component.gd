extends Node2D
class_name WiringComponent

var output_value : float = 0:
	set(value):
		if value == output_value: return
		output_value = value
		output_sent.emit(value)

var input_wire_values : Dictionary[Wire,float] = {}

@export var input_position_node : Node2D = self
@export var output_position_node : Node2D = self

func _ready():
	if !input_position_node: input_position_node = self
	if !output_position_node: output_position_node = self

func recieve_input(value : float, from : Wire):
	input_wire_values[from] = value
	pass

func get_input_values() -> Array[float]: return input_wire_values.values()
func get_total_input() -> float: 
	var total = 0.0
	for value in get_input_values():
		total += value
	return total

signal output_sent()
