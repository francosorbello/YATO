extends GraphNode

signal open_folder(id : String)
signal title_changed(new_title : String)
var folder_id : String

func _on_button_pressed() -> void:
	open_folder.emit(folder_id)

func set_new_title(_title : String):
	$LineEdit.text = _title

func _on_line_edit_focus_exited() -> void:
	title_changed.emit($LineEdit.text)
