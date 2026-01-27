extends WiringComponent

@export var door_origin_node : Node2D = null
@export var door_active_destination : Vector2 = Vector2(0,-60)
@export var door_speed : float = 100.0

var door_active : bool = false

func recieve_input(value : float, from : Wire):
	super(value,from)
	var total_value := get_total_input()
	door_active = total_value != 0

func _process(delta: float) -> void:
	
	var current_door_destination : Vector2 = door_active_destination if door_active else Vector2.ZERO
	var distance = (current_door_destination - door_origin_node.position).length()
	var direction = (current_door_destination - door_origin_node.position).normalized()
	
	door_origin_node.position += min(distance,door_speed * delta) * direction
	
