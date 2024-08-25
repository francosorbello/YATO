extends GraphEdit

enum NodeTypes 
{
    NT_FOLDER,
    NT_COMMENT,
    NT_TASK
}

func _ready() -> void:
    # add buttons to menu bar
    get_menu_hbox().add_child(_create_node_btn("New",_on_new))
    get_menu_hbox().add_child(_create_node_btn("Load",_on_load))
    get_menu_hbox().add_child(_create_node_btn("Save",_on_save))
    get_menu_hbox().add_child(VSeparator.new())
    # add buttons to create nodes
    get_menu_hbox().add_child(_create_node_btn("Comment",_on_comment_add));
    get_menu_hbox().add_child(_create_node_btn("Folder",_on_folder_add))
    get_menu_hbox().add_child(_create_node_btn("Task",_on_task_add))

    # add valid connections
    add_valid_connection_type(NodeTypes.NT_COMMENT,NodeTypes.NT_COMMENT)

## Clear all nodes from view
func clear():
    for child in get_children():
        if child is TodoNode:
            child.queue_free()

## Called when a connection between 2 nodes is requested
func _on_connection_request(from_node:StringName, from_port:int, to_node:StringName, to_port:int) -> void:
    $"%ConnectionController".handle_connection_request(self,from_node,from_port,to_node,to_port)

## Creates a button and connects it to a function
func _create_node_btn(title : String, handler) -> Button:
    var btn = Button.new()
    btn.text = title
    btn.pressed.connect(handler)
    return btn

func _on_new():
    clear()
    get_node("%DBController").clear()
    GlobalData.current_folder_node = GlobalData.get_folder_db().add_root_folder()

## called when adding a comment to the view
func _on_comment_add():
    $Views/CommentView.handle_new_comment(_get_graph_center())

## called when adding a folder to the view
func _on_folder_add():
    $Views/FolderView.handle_new_folder(_get_graph_center())

func _on_task_add():
    $Views/TaskView.handle_new_task(_get_graph_center())

## called when saving
func _on_save():
    get_node("%DBController").save()

## called when loading
func _on_load():
    clear()
    GlobalData.current_folder_node = GlobalData.get_folder_db().add_root_folder()
    get_node("%DBController").load()

## Center of the graph
func _get_graph_center() -> Vector2:
    var screen_size = DisplayServer.window_get_size()
    var x = screen_size.x / 2 - scroll_offset.x + randi_range(-50,50)
    var y = screen_size.y / 2 - scroll_offset.y + randi_range(-50,50)

    return Vector2(x,y)

## Called when a comment changes its text
func _handle_comment_change(id : String, n_comment : String):
    $FolderController.update_comment_node(id,Vector2.ZERO,n_comment)
    pass

## Called when trying to delete nodes
func _on_delete_nodes_request(nodes:Array[StringName]) -> void:
    for child in get_children():
        if child is TodoNode and nodes.has(child.name):
            if child.node_type == NodeTypes.NT_COMMENT:
                get_node("%CommentController").delete_comment(child.model_id)
                get_node("%ConnectionController").delete_connections(child.model_id)
                child.queue_free()
            
            if child.node_type == NodeTypes.NT_FOLDER:
                ## Warning: note the use of db_controller instead of folder_controller
                get_node("%DBController").delete_all_from_folder(child.model_id)
                child.queue_free()
                pass
            if child.node_type == NodeTypes.NT_TASK:
                get_node("%TaskController").delete_task(child.model_id)
                child.queue_free()

## called when trying to disconnect nodes
func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
    get_node("%ConnectionController").handle_disconnect_request(self,from_node,from_port,to_node,to_port)

func _on_return_button_return_to_folder(id:String) -> void:
    $Views/FolderView.on_folder_open(id)
