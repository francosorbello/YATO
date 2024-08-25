extends TodoNodeDB

## Manager of folder models

func add(folder_id: String, data: Dictionary) -> FolderModel:
    var new_folder = FolderModel.new()
    print(data)
    new_folder.folder_uuid = folder_id
    new_folder.position = data.position
    new_folder.title = data.title if data.has("title") else ""
    nodes.append(new_folder)
    return new_folder

func update_title(id: String, data: Dictionary):
    var i = get_node_index(id)
    nodes[i].title = data.title

func add_root_folder():
    return add(GlobalData.PARENT_FOLDER_UUID,{"title": "root", "position": Vector2.ZERO})
