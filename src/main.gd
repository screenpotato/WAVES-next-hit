extends Node2D


@onready var clues: Node = $Clues
@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var clue_popup: PopupPanel = $CanvasLayer/PopupPanel
@onready var popup_label: Label = $CanvasLayer/PopupPanel/PopupLabel

var clues_found: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for clue: Node in clues.get_children():
		clue.player_entered.connect(_on_clue_player_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_clue_player_entered(clue):
	clues_found += 1
	score_label.text = "Clues found: %d/6" % clues_found
	popup_label.text = clue.clue_text
	# bare minimum for playtesting purposes
	# needs to be turned into a proper UI later on
	clue_popup.popup_centered()
	clue.queue_free()


func _on_button_button_up() -> void:
	clue_popup.hide()  # good enough for now, but someone needs to properly design this at some point
