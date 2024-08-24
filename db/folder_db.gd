extends TodoNodeDB

## Manager of folder models

func add(folder_id: String, data: Dictionary):
    var new_folder = FolderModel.new()
    new_folder.folder_uuid = folder_id
    new_folder.title = data.title

func update(id: String, data: Dictionary):
    var i = get_node_index(id)
    nodes[i].title = data

func add_root_folder():
    add(GlobalData.PARENT_FOLDER_UUID,{"title": "root"})
