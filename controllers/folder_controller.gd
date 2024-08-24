class_name FolderController extends Node



func add_comment_node(pos : Vector2) -> CommentModel:
    var comm_node = CommentModel.new()
    comm_node.position = pos
    
    return GlobalData.current_folder_node.add_todo_node(comm_node)

func update_comment_node(id: String, pos: Vector2, comment : String):
    var comm_node = GlobalData.current_folder_node.get_node_by_id(id)
    comm_node.position = pos
    comm_node.comment = comment
    pass

# func delete_c