extends Node

# handles all input related to comments

@export var comment : PackedScene
@export var graph :GraphEdit

func handle_new_comment(graph_center : Vector2):
   
    # add comment to model
    var center = graph_center
    var new_comment = get_node("%CommentController").add_comment_node(center)
   
    if(new_comment == null):
        return

    add_comment_to_view(new_comment)
    

func add_comment_to_view(new_comment : CommentModel):
# instantiate comment
    var comment_instance : TodoNode = comment.instantiate()
    comment_instance.comment_changed.connect(_handle_comment_change)
    comment_instance.moved.connect(_handle_comment_dragged)

    comment_instance.model_id = new_comment.uuid
    if (new_comment.comment != ""):
        comment_instance.set_text(new_comment.comment)
    comment_instance.position_offset.x = new_comment.position.x
    comment_instance.position_offset.y = new_comment.position.y

    graph.add_child(comment_instance)

func load_comments_from_save(comments : ListResource):
    for comm : CommentSaveData in comments.data:
        if comm.folder_uuid != GlobalData.current_folder_node.uuid:
            continue
        get_node("%CommentController").add_comment_node(comm.position,comm.uuid)
        var updated_comm = get_node("%CommentController").update_comment_text(comm.uuid,comm.comment)
        add_comment_to_view(updated_comm)

func load_comments_from_folder(comments):
    for comm in comments:
        if comm.folder_uuid != GlobalData.current_folder_node.uuid:
            continue
        add_comment_to_view(comm)

func _handle_comment_change(id : String, n_comment : String):
    get_node("%CommentController").update_comment_text(id,n_comment)

func _handle_comment_dragged(id : String, new_pos : Vector2):
    get_node("%CommentController").update_comment_position(id,new_pos)

