extends Node2D

@export var tile_size = 32
@export var grid_width = 26
@export var grid_height = 15

#get node grid
@onready var grid = get_node("/root/World/Grid")

func _draw():

	for x in range(grid_width + 1):

			draw_line(
			Vector2(x * tile_size, 0),
			Vector2(x * tile_size, grid_height * tile_size),
			Color.WHITE
			)

	for y in range(grid_height + 1):
		draw_line(
			Vector2(0, y * tile_size),
			Vector2(grid_width * tile_size, y * tile_size),
			Color.WHITE
			)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
