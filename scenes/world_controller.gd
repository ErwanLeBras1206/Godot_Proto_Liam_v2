extends Node

# for mouse hover management
var show_all_labels = false

#define state for game
enum GameState {
	EXPLORATION,
	COMBAT,
	PAUSE
}
#get node world controller
@onready var world_controller = get_node("/root/World/WorldController")
#get node grid
@onready var grid = get_node("/root/World/Grid")

var current_state = GameState.EXPLORATION


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("****************************")
	print("Premiere fenetre deplacement")
	print("2026/04/27")
	print("v0.0")
	print("ELB")
	print("****************************")	
	print("Premiere map arène")
	print("2026/05/03")
	print("v0.1")
	print("ELB")
	print("****************************")
	print("Premier ennemi créé et collisions")
	print("2026/05/05")
	print("v0.2")
	print("ELB")
	print("****************************")
	print("Refonte du projet mal conçu")
	print("2026/05/09")
	print("v0.3")
	print("ELB")
	print("****************************")	
	print("Gestion de l'arène")
	print("2026/05/16")
	print("v0.4")
	print("ELB")
	print("****************************")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):

	if event.is_action_pressed("Exploration_Mode"):
		print("E pressed : exploration mode !")
		start_exploration()

	if event.is_action_pressed("Combat_Mode"):
		print("C pressed : combat mode !")
		start_combat()
	
	if world_controller.current_state != world_controller.GameState.EXPLORATION:
		return
		
	if event.is_action_pressed("show_names"):
		print("Alt pressed : show all informations")
		show_all_labels = true		
	else:
		show_all_labels = false	

func toggle_names():
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	for enemy in enemies:
		var label = enemy.get_node("Area2D/Label")
		label.visible = !label.visible
		
	var players = get_tree().get_nodes_in_group("player")
	for player in players:
		var label1 = player.get_node("CharacterBody2D/Label")
		label1.visible = !label1.visible

func start_combat():
	current_state = GameState.COMBAT
	grid.visible = true
	grid.position = Vector2(224, 128)
	print("Combat started")

func start_exploration():
	current_state = GameState.EXPLORATION
	grid.visible = false
	print("Exploration started")
