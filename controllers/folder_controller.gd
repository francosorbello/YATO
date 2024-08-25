extends Node

func add_folder(pos : Vector2, new_id : String = "") -> FolderModel:
    var folder_db = GlobalData.get_folder_db()
    var folder = folder_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    if new_id != "":
        print("replace with id "+new_id)
        folder = folder_db.replace_id(folder.uuid,new_id)

    return folder

func update_folder_title(id : String, n_title : String) -> FolderModel:
    return GlobalData.get_folder_db().update(id, {"title":n_title})

func update_folder_position(id: String, pos :Vector2) -> FolderModel:
    return GlobalData.get_folder_db().update(id, {"position":pos})

func get_nodes_from_folder(folder_id) -> Array:
    return GlobalData.get_folder_db().get_nodes_from_folder(folder_id)