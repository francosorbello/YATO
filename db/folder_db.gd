extends TodoNodeDB

## Manager of folder models

func add(folder_id: String, data: Dictionary) -> FolderModel:
    var new_folder = FolderModel.new()
    new_folder.folder_uuid = folder_id
    new_folder.position = data.position
    new_folder.title = data.title if data.has("title") else ""
    nodes.append(new_folder)
    return new_folder

func add_root_folder():
    var root_folder = add(GlobalData.PARENT_FOLDER_UUID,{"title": "root", "position": Vector2.ZERO})
    var i = get_node_index(root_folder.uuid)
    nodes[i].uuid = GlobalData.PARENT_FOLDER_UUID
    return nodes[i]

func update(id : String, data : Dictionary) -> FolderModel:
    var i = get_node_index(id)
    if i == -1:
        return null
    
    if data.has("position"):
        nodes[i].position = data.position
    
    if data.has("title"):
        nodes[i].title = data.title
    
    super.update(id,data)
    return nodes[i]

func save():
    var data = ListResource.new()
    for node : FolderModel in nodes:
        if node.uuid == GlobalData.PARENT_FOLDER_UUID:
            continue
        var folder_save_data = FolderSaveData.new()
        folder_save_data.uuid = node.uuid
        folder_save_data.folder_uuid = node.folder_uuid
        folder_save_data.title = node.title
        folder_save_data.position = node.position
        folder_save_data.size = node.size

        data.data.append(folder_save_data)
    return data

func load(folders : ListResource):
    if folders == null:
        return
    for folder in folders.data:
        var new_folder = add(folder.folder_uuid,{"position":folder.position})
        replace_id(new_folder.uuid,folder.uuid)
        update(folder.uuid,{"position":folder.position,"title":folder.title, "size":folder.size})