extends Node

@export var task_item_scene : PackedScene
@export var graph :GraphEdit

func handle_new_task_item(task_id : String):
    # add item to db
    var new_item = get_node("%TaskItemController").add_task_item(task_id)

    if new_item == null:
        return

    # add item to graph
    add_item_to_task(task_id,new_item)

func add_item_to_task(task_id : String, new_item: TaskItemModel):
    for node in graph.get_children():
        if node is TodoNode:
            if node.model_id == task_id:
                var task_item = task_item_scene.instantiate()
                task_item.item_id = new_item.uuid

                task_item.set_activated(new_item.finished)
                if new_item.title != "":
                    task_item.set_item_title(new_item.title)

                # set signals
                task_item.text_changed.connect(_handle_update_title)
                task_item.checkbox_changed.connect(_handle_set_activated)
                task_item.delete_pressed.connect(_handle_delete_item)

                node.add_item(task_item)

func _handle_delete_item(id : String):
    get_node("%TaskItemController").delete_task_item(id)

func _handle_update_title(id : String, new_title : String):
    get_node("%TaskItemController").update_task_item_title(id,new_title)

func _handle_set_activated(id: String, activated: bool):
    get_node("%TaskItemController").update_task_item_activated(id,activated)