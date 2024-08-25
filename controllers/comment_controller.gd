extends Node

func add_comment_node(pos : Vector2, new_id :String ="") -> CommentModel:
    var comment_db = GlobalData.get_comment_db()
    var comm_node = comment_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    if new_id != "":
        comm_node = comment_db.replace_id(comm_node.uuid,new_id)
    return comm_node

func update_comment_text(id: String, comment : String) -> CommentModel:
    return GlobalData.get_comment_db().update(id,{"comment":comment})

func update_comment_position(id: String, pos: Vector2):
    GlobalData.get_comment_db().update(id,{"position":pos})

func delete_comment(id):
    return GlobalData.get_comment_db().delete(id)

func get_comments_from_folder(folder_id : String) -> Array:
    return GlobalData.get_comment_db().get_nodes_from_folder(folder_id)