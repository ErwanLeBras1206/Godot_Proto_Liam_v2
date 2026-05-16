extends CharacterBody2D

@onready var world_controller = get_node("/root/World/WorldController")

# Use to set the speed as a parameter of CharacterBody2D, can be modified directly theree
@export var speed = 200
@export var map_size_x = 1280
@export var map_size_y = 720

#define default entity for player
var entity_name = "PlayerConnected"

#define the first position of character
var last_direction = "front"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	# Define the first frame
	$AnimatedSprite2D.play("idle_front")
	
	#define label name as entity_name and not visible
	$Label.text = entity_name
	$Label.visible = false
	
	#Define start position for character
	position = Vector2(200, 100)
		
	#increase character size x2
	$AnimatedSprite2D.scale = Vector2(2, 2)
	scale = Vector2(1, 1)	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO	
	#if not in exploration player is fixed
	if world_controller.current_state != world_controller.GameState.EXPLORATION:
		return

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()
	#character can't go outside the window
	position.x = clamp(position.x, 32, map_size_x-32)
	position.y = clamp(position.y,32, map_size_y-32)
	
	update_animation(direction)
	
	# Label available if show_all_labels
	$Label.visible = world_controller.show_all_labels	
	
func update_animation(direction):
	if direction != Vector2.ZERO:
		if direction.y < 0:
			last_direction = "back"
			$AnimatedSprite2D.play("walk_back")
		elif direction.y > 0:
			last_direction = "front"
			$AnimatedSprite2D.play("walk_front")
		elif direction.x < 0:
			last_direction = "left"
			$AnimatedSprite2D.play("walk_left")
		elif direction.x > 0:
			last_direction = "right"
			$AnimatedSprite2D.play("walk_right")
	else:
		match last_direction:
			"front":
				$AnimatedSprite2D.play("idle_front")
			"back":
				$AnimatedSprite2D.play("idle_back")
			"left":
				$AnimatedSprite2D.play("idle_left")
			"right":
				$AnimatedSprite2D.play("idle_right")
