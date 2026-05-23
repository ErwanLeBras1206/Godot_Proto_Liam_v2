extends Node2D

@export var cell_size := 32

var player_cell := Vector2i(5, 5)
var enemy_cells = [
	Vector2i(7, 5),
	Vector2i(8, 6)
]

const RADIUS := 11.0
const BORDER_WIDTH := 2.0

func _draw():

	_draw_grid_circle(player_cell,Color(0.2, 0.6, 1.0, 0.70))

	for cell in enemy_cells:
		_draw_grid_circle(cell,Color(1.0, 0.2, 0.2, 0.70))
		
func set_positions(player_pos: Vector2i, enemies: Array):
	player_cell = player_pos
	enemy_cells = enemies
	queue_redraw()
	
func _draw_grid_circle(cell:Vector2i,color:Color):
		var world_pos = Vector2(
		cell.x * cell_size + cell_size / 2 - 1,
		cell.y * cell_size + cell_size / 2 + 2
		)
		
		draw_arc(
	world_pos,
	RADIUS,
	0,
	TAU,
	64,
	color,
	BORDER_WIDTH
)

func clear_circles():

	player_cell = Vector2i(-100, -100)
	enemy_cells.clear()

	queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
