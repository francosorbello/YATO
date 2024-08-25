extends Node

var task_db

func _ready():
    task_db = GlobalData.get_task_db()

func add_task(pos : Vector2):
    var new_task = task_db.add(GlobalData.current_folder_node.uuid,{"position":pos})

    return new_task

func update_task_position(id: String, pos : Vector2):
    return task_db.update(id,{"position":pos})

func update_task_title(id: String, title : String):
    return task_db.update(id,{"title": title})

func delete_task(id) -> TaskModel:
    return task_db.delete(id)

## Get comments inside a folder
func get_nodes_from_folder(folder_id : String) -> Array:
    return task_db.get_nodes_from_folder(folder_id)