extends GraphEdit

enum NodeTypes 
{
    NT_FOLDER,
    NT_COMMENT,
    NT_TASK
}

@export var comment : PackedScene

func _ready() -> void:
    get_menu_hbox().add_child(_create_node_btn("Load",_on_load))
    get_menu_hbox().add_child(_create_node_btn("Save",_on_save))
    get_menu_hbox().add_child(VSeparator.new())
    var comment_btn = _create_node_btn("Comment",_on_comment_add)
    get_menu_hbox().add_child(comment_btn);
    get_menu_hbox().add_child(_create_node_btn("Folder",_on_folder_add))

    add_valid_connection_type(NodeTypes.NT_COMMENT,NodeTypes.NT_COMMENT)

func _on_connection_request(from_node:StringName, from_port:int, to_node:StringName, to_port:int) -> void:
    # connect_node(from_node,from_port,to_node,to_port);
    $"%ConnectionController".handle_connection_request(self,from_node,from_port,to_node,to_port)
    pass # Replace with function body.

func _create_node_btn(title : String, handler) -> Button:
    var btn = Button.new()
    btn.text = title
    btn.pressed.connect(handler)
    return btn

func _on_comment_add():
    $Views/CommentView.handle_new_comment(_get_graph_center())

func _on_folder_add():
    $Views/FolderView.handle_new_folder(_get_graph_center())
    pass

func _on_save():
    # GlobalData.get_comment_db().save()
    GlobalData.get_db_manager().save()

func _on_load():
    clear()
    var project = GlobalData.get_db_manager().load()
    GlobalData.current_folder_node = GlobalData.get_folder_db().add_root_folder()
    $Views/CommentView.load_comments_from_save(project.comments)
    $Views/FolderView.load_folders_from_save(project.folders)
    pass

func _get_graph_center() -> Vector2:
    var screen_size = DisplayServer.window_get_size()
    var x = screen_size.x / 2 + scroll_offset.x + randi_range(-50,50)
    var y = screen_size.y / 2 + scroll_offset.y + randi_range(-50,50)

    return Vector2(x,y)

func _handle_comment_change(id : String, n_comment : String):
    print("changed node "+id+" to "+n_comment)
    $FolderController.update_comment_node(id,Vector2.ZERO,comment)
    pass

func _on_delete_nodes_request(nodes:Array[StringName]) -> void:
    for child in get_children():
        if child is TodoNode and nodes.has(child.name):
            get_node("%CommentController").delete_comment(child.model_id)
            get_node("%ConnectionController").delete_connections(child.model_id)
            child.queue_free()
    pass # Replace with function body.


func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
    get_node("%ConnectionController").handle_disconnect_request(self,from_node,from_port,to_node,to_port)

func clear():
    for child in get_children():
        if child is TodoNode:
            child.queue_free()