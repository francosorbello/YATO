extends TodoNode

signal on_add_item_requested(id)
signal on_title_changed(id, new_title)

func _on_add_item():
    on_add_item_requested.emit(self.model_id)

func add_item(new_item):
    $TaskContainer.add_child(new_item)
    
func delete_item(id):
    for item in $TaskContainer.get_children():
        if item.item_id == id:
            item.queue_free()
            break
            
func set_task_title(_title : String):
    $Title.text = _title

func _on_title_focus_exited() -> void:
    on_title_changed.emit(self.model_id, $Title.text)
