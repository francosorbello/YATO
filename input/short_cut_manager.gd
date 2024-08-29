extends Node

signal on_quick_save
signal on_paste_image(image : Image)
func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("quick_save"):
        on_quick_save.emit()
    
    if Input.is_action_just_pressed("paste"):
        _process_paste()

func _process_paste() -> void:
    if (DisplayServer.clipboard_has_image()):
        on_paste_image.emit(DisplayServer.clipboard_get_image())

    pass # Replace with function body.