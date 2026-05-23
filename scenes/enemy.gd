extends CharacterBody2D

#get access to the WorldController node
@onready var world_controller = get_node("/root/Main//World")

# Use to set the speed as a parameter of CharacterBody2D, can be modified directly theree
@export var speed = 200
@export var map_size_x = 1280
@export var map_size_y = 720

#define default entity for monster
var entity_name = "Bouftou"

var hovered = false

#define position of enemies on grid when fight
@export var cell_size := 32
var grid_pos := Vector2i(0, 0)

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
	print(hovered)
	print("affiche les infos de l'ennemi")

func _on_mouse_exited() -> void:
	hovered = false

func _input_event(viewport, event, shape_idx):

		if event is InputEventMouseButton:
			if event.pressed:
				world_controller.start_combat()

#function to put the enemy on grid
func update_world_position():
	position = Vector2(
		 grid_pos.x * cell_size + cell_size / 2 - 1,
		 grid_pos.y * cell_size + cell_size / 2 - 4
		 )
