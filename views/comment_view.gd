extends Node

# handles all input related to comments

@export var comment : PackedScene

func add_comment_to_view(graph_center : Vector2, graph : GraphEdit):
   
    # add comment to model
    var center = graph_center
    print(center)
    var new_comment = get_node("%CommentController").add_comment_node(center)
   
    if(new_comment == null):
        return
    
    # instantiate comment
    var comment_instance : TodoNode = comment.instantiate()

    comment_instance.comment_changed.connect(_handle_comment_change)
    comment_instance.moved.connect(_handle_comment_dragged)

    comment_instance.model_id = new_comment.uuid
    comment_instance.position_offset.x = new_comment.position.x
    comment_instance.position_offset.y = new_comment.position.y  
    
    graph.add_child(comment_instance)

func _handle_comment_change(id : String, n_comment : String):
    get_node("%CommentController").update_comment_text(id,n_comment)

func _handle_comment_dragged(id : String, new_pos : Vector2):
    get_node("%CommentController").update_comment_position(id,new_pos) 
