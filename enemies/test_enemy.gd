extends StaticBody2D
class_name TestEnemy

@export var health :int= 2

signal died

func take_damage(damage_amount: int) -> void:
	print("Took " + str(damage_amount) + " damage")
	health -= damage_amount
	
	if health <= 0:
		died.emit()
		queue_free()
