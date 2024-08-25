extends TodoNode

signal on_add_item_requested(id)

@export var item_scene : PackedScene

func _on_add_item():
    on_add_item_requested.emit(self.model_id)

func add_item(item_id : String):
    var new_item = item_scene.instantiate()
    new_item.item_id = item_id

    $TaskContainer.add_child(new_item)
