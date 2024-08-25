extends Node

@export var folder_scene : PackedScene
@export var graph : GraphEdit
func handle_new_folder(pos : Vector2):
    var new_folder = GlobalData.get_folder_db().add(GlobalData.current_folder_node.uuid,{"position":pos}) 

    add_folder_to_view(new_folder)

func add_folder_to_view(new_folder : FolderModel):
    var folder_node = folder_scene.instantiate()
    folder_node.position_offset = new_folder.position
    folder_node.model_id = new_folder.uuid
    if new_folder.title != "":
        folder_node.set_new_title(new_folder.title)
    folder_node.open_folder.connect(_on_folder_open)
    folder_node.moved.connect(_handle_folder_dragged)

    graph.add_child(folder_node)

func _on_folder_open(id : String):
    # clear the graph
    graph.clear()

    # replace current folder
    GlobalData.current_folder_node = GlobalData.get_folder_db().get_by_id(id)

    # add comment nodes
    print("get nodes from folder "+id)
    var comments = GlobalData.get_comment_db().get_nodes_from_folder(id)
    print(len(comments))
    for comment in comments:
        get_parent().get_node("CommentView").add_comment_to_view(comment)
    

    
func load_folders_from_save(folders : ListResource):
    for folder : FolderSaveData in folders.data:
        if folder.folder_uuid != GlobalData.current_folder_node.uuid:
            continue
        
        get_node("%FolderController").add_folder(folder.position, folder.uuid)
        var updated_folder = get_node("%FolderController").update_folder_title(folder.uuid,folder.title)

        add_folder_to_view(updated_folder)

func _handle_folder_dragged(id : String, new_pos : Vector2):
    get_node("%FolderController").update_folder_position(id, new_pos)
