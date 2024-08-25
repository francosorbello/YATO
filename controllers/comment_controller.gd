extends Node

var comment_db

func _ready() -> void:
    comment_db = GlobalData.get_comment_db()

## Add comment to database
## [br]
## pos : Position on the graph [br]
## new_id : optional id, will replace the newly generated one
func add_comment(pos : Vector2, new_id :String ="") -> CommentModel:
    var comm_node = comment_db.add(GlobalData.current_folder_node.uuid,{"position": pos})
    if new_id != "":
        comm_node = comment_db.replace_id(comm_node.uuid,new_id)
    return comm_node

func update_comment_text(id: String, comment : String) -> CommentModel:
    return comment_db.update(id,{"comment":comment})

func update_comment_position(id: String, pos: Vector2) -> CommentModel:
    return comment_db.update(id,{"position":pos})

func delete_comment(id) -> CommentModel:
    return comment_db.delete(id)

## Get comments inside a folder
func get_nodes_from_folder(folder_id : String) -> Array:
    return comment_db.get_nodes_from_folder(folder_id)