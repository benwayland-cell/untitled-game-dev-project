extends CharacterBody2D

@export var jump_grav :int= 500
@export var fall_grav :int= 1000
@export var speed :int= 10000
@export var jump_velocity :int= 300
@export var min_jump_velocity :int= 50

@export var sword_active_time :float= 0.5
@export var sword_cooldown_time :float= 1.0

# abililities unlocked
var has_sword :bool= false
var has_double_jump_ability :bool= false

enum PlayerState {ON_GROUND, JUMPING, FALLING}

var player_state := PlayerState.FALLING

var sword_is_active :bool= false
var can_double_jump :bool= true


func _process(delta: float) -> void:
	_update_player_state()
	_handle_left_right(delta)
	_handle_grav(delta)
	_handle_jumping()
	_handle_sword()
	_handle_debug()
	
	move_and_slide()

func _update_player_state() -> void:
	if (is_on_floor()):
		player_state = PlayerState.ON_GROUND
		can_double_jump = true
	
	# if the player has let go of the jump button and has reached the min_jump_velocity
	# or they are falling
	elif ((velocity.y < -min_jump_velocity and not Input.is_action_pressed("jump")) or velocity.y > 0):
		player_state = PlayerState.FALLING

func _handle_left_right(delta: float) -> void:
	var direction :float= 0.0
	
	if Input.is_action_pressed("left"):
		direction += -1.0
	if Input.is_action_pressed("right"):
		direction += 1.0
	
	velocity.x = direction * delta * speed


func _handle_jumping() -> void:
	# check if we can jump
	var can_jump :bool= false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			can_jump = true
		elif has_double_jump_ability and can_double_jump:
			can_jump = true
			can_double_jump = false
	
	if not can_jump:
		return
	
	
	velocity.y = -jump_velocity
	player_state = PlayerState.JUMPING
	


func _handle_grav(delta: float) -> void:
	if player_state == PlayerState.JUMPING:
		velocity.y += jump_grav * delta
	else:
		velocity.y += fall_grav * delta


func _handle_sword() -> void:
	if not (Input.is_action_just_pressed("sword") and not sword_is_active):
		return
	
	sword_is_active = true
	%Sword.show()
	await get_tree().create_timer(sword_active_time).timeout
	sword_is_active = false
	%Sword.hide()


func _handle_debug() -> void:
	if Input.is_action_just_pressed("debug 1"):
		has_sword = !has_sword
		print("Sword: " + str(has_sword))
	if Input.is_action_just_pressed("debug 2"):
		has_double_jump_ability = !has_double_jump_ability
		print("Double jump: " + str(has_double_jump_ability))


func _on_sword_body_entered(body: Node2D) -> void:
	if not sword_is_active:
		return
	
	if body.is_in_group("enemies"):
		body.take_damage(1)
