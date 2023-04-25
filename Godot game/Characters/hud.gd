extends CanvasLayer

var lives : int = 3


func _ready():
	$End.hide()
	$Quit.hide()
	$EndBackground.hide()


func updateLives():
	lives -= 1
	$Lives.text = str(lives)


func updateMainQuestToki():
	$MainQuest.text = "Main Quest: Find Flappy at the house up north"
	$SideQuest.text = "Side Quest: "


func updateMainQuestFlappy():
	$MainQuest.text = "Main Quest: Go to the field in the far east"
	$SideQuest.text = "Side Quest: Find the red toy"


func updateMainQuestPecky():
	$MainQuest.text = "Main Quest: Remove the trees to get to the field"
	

func updateMainQuestEggy():
	$MainQuest.text = "Main Quest: Defeat the big cow"


func removeSideQuest():
	$SideQuest.text = "Side Quest: "
	
	
func showEnd():
	$EndBackground.show()
	$End.show()
	$Quit.show()


func _on_quit_pressed():
	get_tree().quit()
