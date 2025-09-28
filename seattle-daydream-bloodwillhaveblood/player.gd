extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var attacking = false

func _ready() -> void:
	animated_sprite_2d.play("idle")

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
		

	# Attack input
	if Input.is_action_just_pressed("attack") and not attacking:
		attacking = true
		animated_sprite_2d.play("attack1")  # make sure attack1 is NON-LOOPING

	# Horizontal movement
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		# Play walk only if not attacking
		if not attacking:
			animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Return to idle after attack finishes
	if attacking and not animated_sprite_2d.is_playing():
		attacking = false
		# Play idle if not moving
		if direction == 0:
			animated_sprite_2d.play("idle")
