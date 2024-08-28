extends Node

# handles all input related to comments

@export var comment : PackedScene
@export var graph :GraphEdit

func _ready() -> void:
    GlobalEventSystem.suscribe(self,"_handle_global_events")

## Called when adding a new comment from UI
func handle_new_comment(graph_center : Vector2):
   
    # add comment to model
    var center = graph_center
    var new_comment = get_node("%CommentController").add_comment(center)
   
    if(new_comment == null):
        return

    add_comment_to_view(new_comment)

## Adds a comment to the view, based on their model
func add_comment_to_view(new_comment : CommentModel):
# instantiate comment
    var comment_instance : TodoNode = comment.instantiate()
    comment_instance.comment_changed.connect(_handle_comment_change)
    comment_instance.moved.connect(_handle_comment_dragged)
    comment_instance.node_resized.connect(_handle_comment_resized)

    comment_instance.model_id = new_comment.uuid
    if (new_comment.comment != ""):
        comment_instance.set_text(new_comment.comment)
    comment_instance.position_offset.x = new_comment.position.x
    comment_instance.position_offset.y = new_comment.position.y
    if new_comment.size != Vector2.ZERO:
        comment_instance.size = new_comment.size

    graph.add_child(comment_instance)


## Get comments from db and load them into view
func load_nodes_from_folder(folder_id : String):
    var comments = get_node("%CommentController").get_nodes_from_folder(folder_id)
    for comm in comments:
        add_comment_to_view(comm) 

## Called when a comment changes their text
func _handle_comment_change(id : String, n_comment : String):
    get_node("%CommentController").update_comment_text(id,n_comment)

## Called when a comment is dragged
func _handle_comment_dragged(id : String, new_pos : Vector2):
    get_node("%CommentController").update_comment_position(id,new_pos)

## Event system callback
func _handle_global_events(event, _msg : Dictionary):
    if event == GlobalEventSystem.GameEvent.GE_LOADED:
        # load_comments_from_save()
        load_nodes_from_folder(GlobalData.current_folder_node.uuid)
    
    if event == GlobalEventSystem.GameEvent.GE_FOLDER_OPENED:
        load_nodes_from_folder(_msg.folder_id)

func _handle_comment_resized(id : String, new_size : Vector2):
    print("comment resized")
    get_node("%CommentController").resize(id,new_size)