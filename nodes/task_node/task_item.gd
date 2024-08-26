extends HBoxContainer

var item_id : String

signal text_changed(id, text)
signal checkbox_changed(id, checked)
signal delete_pressed(id)

func _on_line_edit_focus_exited() -> void:
    print("focus exited")
    text_changed.emit(item_id,$LineEdit.text)

func _on_delete_pressed() -> void:
    delete_pressed.emit(item_id)
    pass # Replace with function body.

func _on_check_box_toggled(toggled_on:bool) -> void:
    print("toggled")
    checkbox_changed.emit(item_id,toggled_on)
    pass # Replace with function body.

func set_activated(activated:bool) -> void:
    $CheckBox.button_pressed = activated

func set_item_title(title : String) -> void:
    print("Set text to %s"%title)
    $LineEdit.text = title