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
@onready var world_controller = get_node("/root/Main/World")
#get node grid
@onready var grid = get_node("/root/Main/World/GridOverlay/Grid")
#get player
@onready var player = get_node("/root/Main/World/Units/PlayerUnit")
#get enemies
@onready var enemies = get_node("/root/Main/World/Units/EnemyUnits")
#get camera
@onready var camera = get_node("/root/Main/World/Camera2D")
#get arena center
@onready var arena_center = $ArenaCenter

#define that the game begin by exploration
var current_state = GameState.EXPLORATION

#save the actual player position
var player_saved_position : Vector2

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
	print("Refonte projet")
	print("2026/05/20")
	print("v0.5")
	print("ELB")
	print("****************************")
	print("Passage mode combat en mode exploration")
	print("2026/05/23")
	print("v0.6")
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
		
	if event.is_action_pressed("Abandoned"):
		print("A pressed : used to stop fight")
		if world_controller.current_state == world_controller.GameState.COMBAT	:
			#set the actual position of player	
			start_exploration()
	
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
	#save the actual position of player
	player_saved_position = get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D").global_position
	print(player_saved_position)
	#set the game state to FIGHT
	current_state = GameState.COMBAT
	#grid is visible
	grid.visible = true
	#put the grid at the good place
	grid.position = Vector2(414, 224)
	#place the player on the grid and put it in	
	
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D/AnimatedSprite2D").play("idle_back")
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D").grid_pos = Vector2i(25,15)
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D").update_world_position()	
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D/AnimatedSprite2D").scale = Vector2(0.8, 0.8)	
	#place the enemies on the grid	
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").grid_pos = Vector2i(15,7)	
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").update_world_position()
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D/AnimatedSprite2D").scale = Vector2(0.16, 0.16)
	#add the shadow circle
	get_parent().get_node("/root/Main/World/GridOverlay").set_positions(
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D").grid_pos,
	[
		get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").grid_pos
	]
)
	
	var tween = create_tween()

	tween.parallel().tween_property(
		camera,
		"zoom",
		Vector2(1.6, 1.6),
		0.4
	)

	tween.parallel().tween_property(
		camera,
		"global_position",
		arena_center.global_position,
		0.4
	)
		
	print("Combat started")

func start_exploration():
	current_state = GameState.EXPLORATION
	grid.visible = false
	
	var tween = create_tween()

	tween.parallel().tween_property(
		camera,
		"zoom",
		Vector2(1.0, 1.0),
		0.4
	)
	
	#put the player position at its position before fight
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D").position = player_saved_position
	get_parent().get_node("/root/Main/World/Units/PlayerUnit/CharacterBody2D/AnimatedSprite2D").scale = Vector2(1.5, 1.5)
		
	#remove shadow circles
	get_parent().get_node("/root/Main/World/GridOverlay").clear_circles()
	
	#remove the mob from the map*
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").visible = false
	
	print("Exploration started")
	
	#wait a little time
	await get_tree().create_timer(3.0).timeout
	
	#visible to true
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").visible = true
	#spawn again the mob in the middle of the arena
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D").global_position = arena_center.global_position
	#animated sprite 2D
	get_parent().get_node("/root/Main/World/Units/EnemyUnits/CharacterBody2D/AnimatedSprite2D").scale = Vector2(0.5, 0.5)
	
	print("A monster has spawned on the map")
	
