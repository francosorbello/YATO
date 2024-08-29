extends TodoNode

signal code_changed(id : String, code : String)

func _on_code_edit_focus_exited() -> void:
    code_changed.emit(model_id, $TextEdit.text)