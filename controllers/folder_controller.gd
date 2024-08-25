extends Node

var folder_db

func _ready() -> void:
    folder_db = GlobalData.get_folder_db()

## Add folder to database
## [br]
## pos : Position on the graph [br]
## new_id : optional id, will replace the newly generated one
func add_folder(pos : Vector2, new_id : String = "") -> FolderModel:
    var folder = folder_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    if new_id != "":
        folder = folder_db.replace_id(folder.uuid,new_id)

    return folder

func update_folder_title(id : String, n_title : String) -> FolderModel:
    return folder_db.update(id, {"title":n_title})

func update_folder_position(id: String, pos :Vector2) -> FolderModel:
    return folder_db.update(id, {"position":pos})

## Get folders inside another folder
func get_nodes_from_folder(folder_id) -> Array:
    return folder_db.get_nodes_from_folder(folder_id)