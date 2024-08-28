extends Node
## View in charge of displaying task items and managing their input

@export var task_item_scene : PackedScene
@export var graph :GraphEdit

## Handles being asked for a new item
func handle_new_task_item(task_id : String):
    # add item to db
    var new_item = get_node("%TaskItemController").add_task_item(task_id)

    if new_item == null:
        return

    # add item to graph
    add_item_to_task(task_id,new_item)

## Adds a new task item to the view
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

## handles deleting an item from a task
func _handle_delete_item(id : String, slot : int):
    var deleted_item = get_node("%TaskItemController").delete_task_item(id)
    for node in graph.get_children():
        if node is TodoNode and node.model_id == deleted_item.folder_uuid:
            node.delete_item(id)
            GlobalEventSystem.emit(GlobalEventSystem.GameEvent.GE_TASK_ITEM_DELETED,{"item":deleted_item,"slot":slot})
            return
## handles updating the title of a item            
func _handle_update_title(id : String, new_title : String):
    get_node("%TaskItemController").update_task_item_title(id,new_title)

## handles toggling a item
func _handle_set_activated(id: String, activated: bool):
    get_node("%TaskItemController").update_task_item_activated(id,activated)