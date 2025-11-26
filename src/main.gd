extends Node2D


@onready var clues: Node = $Clues
@onready var score_label: Label = $CanvasLayer/VBoxContainer/ScoreLabel
@onready var clue_popup: PopupPanel = $CanvasLayer/PopupPanel
@onready var popup_label: Label = $CanvasLayer/PopupPanel/PopupLabel
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player: CharacterBody2D = $Player
@onready var inventory_panel: PanelContainer = $CanvasLayer/Inventory
@onready var inventory_list: ItemList = $CanvasLayer/Inventory/ItemList
@onready var shop_panel: PanelContainer = $CanvasLayer/Shop

var clues_found: int = 0
var items_in_inventory: Array = []
var texture_item = preload("res://art/item.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.diving.connect(_on_player_diving)
	for clue: Node in clues.get_children():
		clue.player_entered.connect(_on_clue_player_entered)


func _input(event) -> void:
	if event.is_action_pressed("inventory"):
		inventory_panel.visible = not inventory_panel.visible
		# TODO: pause game while inventory is open?
		# TODO: make inventory look decent
	if event.is_action_pressed("shop"):
		shop_panel.visible = not shop_panel.visible
		# TODO: make shop functional
		# TODO: make inventory look decent



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_clue_player_entered(clue):
	clues_found += 1
	score_label.text = "Clues found: %d/6" % clues_found
	popup_label.text = clue.clue_text
	# bare minimum for playtesting purposes
	# needs to be turned into a proper UI later on
	inventory_list.add_item(clue.clue_text, texture_item)
	clue_popup.popup_centered()
	clue.queue_free()


func _on_button_button_up() -> void:
	clue_popup.hide()  # good enough for now, but someone needs to properly design this at some point


func _on_player_diving() -> void:
	audio_player.play()
