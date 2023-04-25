extends StaticBody2D


@onready var HUD = get_node('/root/GameLevel/HUD')


func _ready():
	pass


func destroyMe():
	HUD.removeSideQuest()
	queue_free()
