extends Node

var task_item_db
var slot_count : int = 0
func _ready():
    task_item_db = GlobalData.get_task_item_db()

func add_task_item(task_id : String, new_id :String ="") -> TaskItemModel:
    slot_count += 1
    var task_item = task_item_db.add(task_id,{})
    if new_id != "":
        task_item = task_item_db.replace_id(task_item.uuid,new_id)
    return task_item

func delete_task_item(id : String) -> TaskItemModel:
    slot_count -= 1
    return task_item_db.delete(id)

func update_task_item_title(id : String, title : String) -> TaskItemModel:
    return task_item_db.update(id,{"title":title})

func update_task_item_activated(id : String, activated : bool) -> TaskItemModel:
    return task_item_db.update(id,{"finished":activated})

## Get comments inside a folder
func get_items_for_task(task_id : String) -> Array:
    return task_item_db.get_items_for_task(task_id)