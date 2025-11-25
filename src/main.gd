extends Node2D


@onready var clues: Node = $Clues


var clues_found: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for clue: Node in clues.get_children():
		clue.player_entered.connect(_on_clue_player_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_clue_player_entered(clue):
	clue.queue_free()
