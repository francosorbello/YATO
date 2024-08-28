extends HBoxContainer

var item_id : String
var slot : int
signal text_changed(id, text)
signal checkbox_changed(id, checked)
signal delete_pressed(id, slot)

func _on_line_edit_focus_exited() -> void:
    text_changed.emit(item_id,$LineEdit.text)

func _on_delete_pressed() -> void:
    delete_pressed.emit(item_id, slot)
    pass # Replace with function body.

func _on_check_box_toggled(toggled_on:bool) -> void:
    checkbox_changed.emit(item_id,toggled_on)
    # $LineEdit.set_tex
    var color = Color.WHITE if not toggled_on else Color.DARK_GRAY
    $LineEdit.set("theme_override_colors/font_color",color)
    pass # Replace with function body.

func set_activated(activated:bool) -> void:
    $CheckBox.button_pressed = activated

func set_item_title(title : String) -> void:
    $LineEdit.text = title

func update_slot(slot_index:int) -> void:
    if slot > slot_index:
        slot -= 1
    pass # Replace with function body.