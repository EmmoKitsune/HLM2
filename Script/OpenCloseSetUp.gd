extends Panel

@onready var menu : Panel = $"."

func _ready():
	_closeSetUp()

func _closeSetUp():
	menu.visible = false
	menu.process_mode = Node.PROCESS_MODE_DISABLED
	
func _openSetUp():
	menu.visible = true
	menu.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_button_pressed():
	_closeSetUp()
