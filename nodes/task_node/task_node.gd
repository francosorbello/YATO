extends TodoNode

signal on_add_item_requested(id)
signal on_title_changed(id, new_title)
var slot_count = 1
func _on_add_item():
    on_add_item_requested.emit(self.model_id)

func add_item(new_item):
    add_child(new_item)
    move_child(new_item,get_children().size() - 2)
    new_item.slot = slot_count - 1
    slot_count += 1
    set_slot(slot_count,true,1,Color.WHITE,true,1,Color.WHITE)
    
func delete_item(id):
    var slot_index = 0 
    for item in get_children():
        if not item is HBoxContainer:
            continue 
        if item.item_id == id:
            set_slot(slot_count,false,1,Color.WHITE,false,1,Color.WHITE)
            clear_slot(slot_index)
            item.queue_free()
            slot_count -= 1
            break
        slot_index += 1

func set_task_title(_title : String):
    $Title.text = _title

func _on_title_focus_exited() -> void:
    on_title_changed.emit(self.model_id, $Title.text)


func _on_slot_updated(slot_index:int) -> void:
    print("Slot updated: ",slot_index)
    pass # Replace with function body.
