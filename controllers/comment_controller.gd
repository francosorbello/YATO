extends Node


func add_comment_node(pos : Vector2) -> CommentModel:
    var comment_db = DatabaseManager.get_comment_db()
    var comm_node =comment_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    
    return comm_node 

func update_comment_text(id: String, comment : String):
    var comm_node = GlobalData.current_folder_node.get_node_by_id(id)
    comm_node.comment = comment 

func update_comment_position(id: String, pos: Vector2):
    var comm_node = GlobalData.current_folder_node.get_node_by_id(id)
    comm_node.position = pos

func delete_comment(id):
    GlobalData.current_folder_node.remove_todo_node(id)
    pass