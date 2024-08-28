extends Node

signal on_quick_save

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("quick_save"):
        on_quick_save.emit()
        pass # Replace with function body.