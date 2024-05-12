extends Control

@onready var pathField : LineEdit = $Setup/VBoxContainer/Path/LineEdit
@onready var MnameField : LineEdit =  $Setup/VBoxContainer/ModName/LineEdit
@onready var consoleLabel : Label = $Main/Konsole/Content

var path : String
var Mname : String

var liblist_content = """
// Valve Game Info file
//  These are key/value pairs.  Certain mods will use different settings.
//
game "{name}"
startmap "c0a0"
trainmap "t0a0"
mpentity "info_player_deathmatch"
gamedll "dlls/hl.dll"
gamedll_linux "dlls/hl.so"
gamedll_osx "dlls/hl.dylib"
secure "1"
type "singleplayer_only"
animated_title "1"
hd_background "1"
"""

var liblistCUSTOM : String

func _ready():
	_printInKonsole("* Console started!\n")

func _CreateMod():
	if( path != null and Mname !=null):
		path = pathField.text
		Mname = MnameField.text

		#Create folders
		var modFolder = DirAccess.make_dir_absolute(path + "/" + Mname)
		_printInKonsole("* Mod folder: Ready!")
		
		var modPath = path + "/" + Mname
		var cl_dllsFolder = DirAccess.make_dir_absolute(modPath + "/cl_dlls")
		_printInKonsole("* CL_DLL'S folder: Ready!")
		
		var dlls_folder = DirAccess.make_dir_absolute(modPath + "/dlls")
		_printInKonsole("* DLL'S folder: Ready!")
		
		#Optionals folders
		if($Setup/VBoxContainer/CheckBox.button_pressed == true):
			var mapsFolder = DirAccess.make_dir_absolute(modPath + "/maps")
			_printInKonsole("* Maps folder: Ready!")
			var gfxFolder = DirAccess.make_dir_absolute(modPath + "/gfx")
			_printInKonsole("* GFX folder: Ready!")
			var soundFolder = DirAccess.make_dir_absolute(modPath + "/sound")
			_printInKonsole("* Sounds folder: Ready!")
			var modelsFolder = DirAccess.make_dir_absolute(modPath + "/models")
			_printInKonsole("* Models folder: Ready!")
			var resourceFolder = DirAccess.make_dir_absolute(modPath + "/resource")
			_printInKonsole("* Resources folder: Ready!")
			var spritesFolder = DirAccess.make_dir_absolute(modPath + "/sprites")
			_printInKonsole("* Sprites folder: Ready!")

		#Liblist.gam things
		liblistCUSTOM = liblist_content.format({"name": Mname})

		var liblistfile = FileAccess.open(modPath + "/liblist.gam",FileAccess.WRITE)
		liblistfile.store_string(liblistCUSTOM)
		liblistfile = null
		_printInKonsole("* Liblist: Ready!")
		
		#Copy dlls
		_copyDLLs(path,modPath)
		_printInKonsole("* Copy DLL's: Ready!")
		_printInKonsole("* Mod {name} created!".format({"name": Mname}))

func _on_create_mod_pressed():
	_CreateMod()

func _copyDLLs(path,modpath):
	var client_dll = DirAccess.copy_absolute(path + "/valve/cl_dlls/client.dll",modpath + "/cl_dlls/client.dll")
	var client_so = DirAccess.copy_absolute(path + "/valve/cl_dlls/client.so",modpath + "/cl_dlls/client.so")
	
	var hl_dll = DirAccess.copy_absolute(path + "/valve/dlls/hl.dll",modpath + "/dlls/hl.dll")
	var hl_so = DirAccess.copy_absolute(path + "/valve/dlls/hl.dll",modpath + "/dlls/hl.so")

func _printInKonsole(text):
	consoleLabel.text += text + "\n"

func _on_clear_pressed():
	consoleLabel.text = ""

func _on_button_pressed():
	$Config._openSetUp()
