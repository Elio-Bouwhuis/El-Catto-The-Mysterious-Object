extends StaticBody2D


const Balloon = preload("res://Dialogues/balloon.tscn")


@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

@onready var HUD = get_node('/root/GameLevel/HUD')
@onready var timerFlappy = get_node("TimerFlappy")
@onready var player = get_node('/root/GameLevel/PlayerCat')

var freezeMoveFlappy : int = 20


func _on_area_2d_body_entered(body):
	timerFlappy.start(freezeMoveFlappy)
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
	HUD.updateMainQuestFlappy()
	player.setMoveOff()


func _on_timer_timeout():
	player.setMoveOn()
