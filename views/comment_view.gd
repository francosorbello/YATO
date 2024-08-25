extends Node

# handles all input related to comments

@export var comment : PackedScene
@export var graph :GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

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

func load_comments_from_folder(folder_id : String):
    # Get comments from db and load them into view
    var comments = get_node("%CommentController").get_comments_from_folder(folder_id)
    for comm in comments:
        add_comment_to_view(comm) 

func _handle_comment_change(id : String, n_comment : String):
    get_node("%CommentController").update_comment_text(id,n_comment)

func _handle_comment_dragged(id : String, new_pos : Vector2):
    get_node("%CommentController").update_comment_position(id,new_pos)

func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        # load_comments_from_save()
        load_comments_from_folder(GlobalData.current_folder_node.uuid)
    