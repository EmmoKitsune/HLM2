extends Control

@onready var pathField : LineEdit = $Config/VBoxContainer/Path/LineEdit
@onready var MnameField : LineEdit =  $Config/VBoxContainer/ModName/LineEdit

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

func _CreateMod():
	if( path != null and Mname !=null):
		path = pathField.text
		Mname = MnameField.text

		#Create folders
		var modFolder = DirAccess.make_dir_absolute(path + "/" + Mname)
		var modPath = path + "/" + Mname
		var cl_dllsFolder = DirAccess.make_dir_absolute(modPath + "/cl_dlls")
		var mapsFolder = DirAccess.make_dir_absolute(modPath + "/maps")
		var dlls_folder = DirAccess.make_dir_absolute(modPath + "/dlls")

		#Liblist.gam things
		liblistCUSTOM = liblist_content.format({"name": Mname})

		var liblistfile = FileAccess.open(modPath + "/liblist.gam",FileAccess.WRITE)
		liblistfile.store_string(liblistCUSTOM)
		liblistfile = null
		
		#Copy dlls
		_copyDLLs(path,modPath)

		_debug(liblistCUSTOM,modPath,path)

func _debug(liblist,mpath,path):
	print(liblist)
	print(mpath)
	print(path)

func _on_create_mod_pressed():
	_CreateMod()

func _copyDLLs(path,modpath):
	var client_dll = DirAccess.copy_absolute(path + "/valve/cl_dlls/client.dll",modpath + "/cl_dlls/client.dll")
	var client_so = DirAccess.copy_absolute(path + "/valve/cl_dlls/client.so",modpath + "/cl_dlls/client.so")
	
	var hl_dll = DirAccess.copy_absolute(path + "/valve/dlls/hl.dll",modpath + "/dlls/hl.dll")
	var hl_so = DirAccess.copy_absolute(path + "/valve/dlls/hl.dll",modpath + "/dlls/hl.so")
