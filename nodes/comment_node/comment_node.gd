extends TodoNode 

signal comment_changed(id : String,comment : String)

func _on_text_edit_focus_exited() -> void:
    comment_changed.emit(self.model_id, $TextEdit.text)
    pass # Replace with function body.
