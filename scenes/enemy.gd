extends Area2D

#get access to the WorldController node
@onready var world_controller = get_node("/root/World/WorldController")

# Use to set the speed as a parameter of CharacterBody2D, can be modified directly theree
@export var speed = 200
@export var map_size_x = 1280
@export var map_size_y = 720

#define default entity for monster
var entity_name = "Bouftou"

var hovered = false

func _ready() -> void:
	#Define start position for character
	position = Vector2(600, 350)
	print("Le monstre est positionné dans l'arène")
	
#define label name as entity_name and not visible
	$Label.text = entity_name
	$Label.visible = false
	
func _physics_process(delta: float) -> void:
	if world_controller.current_state != world_controller.GameState.EXPLORATION:
		$Label.visible = false
		return
		
	$Label.visible = hovered or world_controller.show_all_labels

func _on_mouse_entered() -> void:
	hovered = true
	print("affiche les infos de l'ennemi")

func _on_mouse_exited() -> void:
	hovered = false

func _input_event(viewport, event, shape_idx):

		if event is InputEventMouseButton:
			if event.pressed:
				world_controller.start_combat()
