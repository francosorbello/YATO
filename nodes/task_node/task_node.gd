extends TodoNode

signal on_add_item_requested(id)
signal on_title_changed(id, new_title)
@export var item_scene : PackedScene

func _on_add_item():
    on_add_item_requested.emit(self.model_id)

func add_item(item_id : String):
    var new_item = item_scene.instantiate()
    new_item.item_id = item_id

    $TaskContainer.add_child(new_item)

func set_task_title(_title : String):
    $Title.text = _title

func _on_title_focus_exited() -> void:
    on_title_changed.emit(self.model_id, $Title.text)
