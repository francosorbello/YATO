extends Control

signal context_menu_selected(index:int)

func _ready() -> void:
    visible = false

func _on_item_list_item_selected(index:int) -> void:
    context_menu_selected.emit(index)
    $ItemList.deselect_all()
    visible = false

func travel_to_mouse_pos():
    var mouse_pos = get_global_mouse_position()
    position = mouse_pos

func _input(event):
   # Mouse in viewport coordinates.
   if event is InputEventMouseButton:
        if event.double_click:
           travel_to_mouse_pos()
           visible = true
        if visible and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            visible = false

func _on_mouse_exited() -> void:
    visible = false


func _on_focus_exited() -> void:
    visible = false
    pass # Replace with function body.
