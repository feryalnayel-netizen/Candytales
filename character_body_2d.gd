extends CharacterBody2D


const SPEED = 300.0
var JUMP_VELOCITY = -600.0

@onready var animatedsprite = $bobby

var jumpmax = 1
var jumpcount = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		$coyote.start()
		jumpcount = 0
		
	if Input.is_action_just_pressed("up"):
		$buffer.start()
	
	if  not $coyote.is_stopped() and jumpcount < jumpmax and not $buffer.is_stopped():
		velocity.y = JUMP_VELOCITY
		jumpcount +=1
		$coyote.stop()
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		animatedsprite.play("walk")
		animatedsprite.flip_h = direction>0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedsprite.play("idle")

	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('killblock'):
		global_position = Vector2(0,0)
	elif area.is_in_group('jello'):
		JUMP_VELOCITY = -850.0
	elif area.is_in_group('biscuit'):
		JUMP_VELOCITY = -600.0
		

	 


func _on_restart_pressed() -> void:
		global_position = Vector2(0,0)
