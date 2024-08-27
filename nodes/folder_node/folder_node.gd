extends TodoNode

signal open_folder(id : String)
signal title_changed(new_title : String)

func _on_button_pressed() -> void:
	open_folder.emit(model_id)

func set_new_title(_title : String):
	$LineEdit.text = _title

func _on_line_edit_focus_exited() -> void:
	title_changed.emit(self.model_id,$LineEdit.text)
