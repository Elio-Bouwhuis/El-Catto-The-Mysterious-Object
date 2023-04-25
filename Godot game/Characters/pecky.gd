extends StaticBody2D


const Balloon = preload("res://Dialogues/balloon.tscn")


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@onready var HUD = get_node('/root/GameLevel/HUD')
@onready var timer = get_node("Timer")
@onready var player = get_node('/root/GameLevel/PlayerCat')

var freezeMove : int = 6


func _on_area_2d_body_entered(body):
	timer.start(freezeMove)
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	HUD.updateMainQuestPecky()
	player.setMoveOff()


func _on_timer_timeout():
	player.setMoveOn()
