extends HBoxContainer

var item_id : String

signal text_changed(id, text)

func _on_line_edit_focus_exited() -> void:
    text_changed.emit(item_id,$LineEdit.text)