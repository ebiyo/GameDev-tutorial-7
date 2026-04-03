extends Interactable

@export var light : NodePath
@export var on_by_default = true
@export var energy_when_on = 10
@export var energy_when_off = 2
@export var press_offset : Vector3 = Vector3(0, 0, 0.2)
var original_position : Vector3
@onready var button = $".."
@onready var message_label = get_tree().get_root().get_node("Level/CanvasLayer/Label")

@onready var light_node : Light3D = get_node(light)

var on = on_by_default

func _ready():
	original_position = button.position
	light_node.light_energy = energy_when_on if on else energy_when_off
	update_visual()

func interact():
	on = !on
	light_node.light_energy = energy_when_on if on else energy_when_off
	update_visual()
	
	if on:
		show_message("it escapes for now.")
	else:
		show_message("you've invited darkness")

func update_visual():
	if on:
		button.position = original_position
	else:
		button.position = original_position + press_offset

func show_message(text):
	message_label.text = text
	message_label.visible = true
	
	await get_tree().create_timer(3).timeout
	
	message_label.visible = false
