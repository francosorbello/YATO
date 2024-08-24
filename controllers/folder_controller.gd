class_name FolderController extends Node

var current_folder : FolderModel
var previous_folder : FolderModel

func _ready():
    if current_folder == null:
        current_folder = FolderModel.new()

func add_comment_node(pos : Vector2) -> CommentModel:
    var comm_node = CommentModel.new()
    comm_node.position = pos
    
    return current_folder.add_todo_node(comm_node)

func update_comment_node(id: String, pos: Vector2, comment : String):
    var comm_node = current_folder.get_node_by_id(id)
    comm_node.position = pos
    comm_node.comment = comment
    pass

# func delete_c