extends Node

func add_comment_node(pos : Vector2) -> CommentModel:
    var comment_db = GlobalData.get_comment_db()
    var comm_node = comment_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    
    return comm_node 

func update_comment_text(id: String, comment : String):
    GlobalData.get_comment_db().update(id,{"comment":comment})

func update_comment_position(id: String, pos: Vector2):
    GlobalData.get_comment_db().update(id,{"position":pos})

func delete_comment(id):
    GlobalData.get_comment_db().delete(id)
    pass

func save_test():
    GlobalData.get_comment_db().save()