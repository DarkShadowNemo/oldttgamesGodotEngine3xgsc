tool
extends EditorPlugin

var oldttgamesgsc


func _enter_tree():
	oldttgamesgsc = preload("gsc_importer_plugin.gd").new()
	add_import_plugin(oldttgamesgsc)


func _exit_tree():
	remove_import_plugin(oldttgamesgsc)
	oldttgamesgsc = null
