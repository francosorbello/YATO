extends GraphEdit

enum NodeTypes 
{
    NT_FOLDER,
    NT_COMMENT,
    NT_TASK
}

@export var comment : PackedScene

func _ready() -> void:
    var comment_btn = _create_node_btn("Comment",_on_comment_add)
    get_menu_hbox().add_child(comment_btn);
    add_valid_connection_type(NodeTypes.NT_COMMENT,NodeTypes.NT_COMMENT)

func _on_connection_request(from_node:StringName, from_port:int, to_node:StringName, to_port:int) -> void:
    connect_node(from_node,from_port,to_node,to_port);
    pass # Replace with function body.

func _create_node_btn(title : String, handler) -> Button:
    var btn = Button.new()
    btn.text = title
    btn.pressed.connect(handler)
    return btn

func _on_comment_add():
    var comment_instance : TodoNode = comment.instantiate()
    add_child(comment_instance)
    var center = _get_graph_center()
    comment_instance.position_offset.x = center.x
    comment_instance.position_offset.y = center.y  
    pass

func _get_graph_center():
    var screen_size = DisplayServer.window_get_size()
    var x = screen_size.x / 2 + scroll_offset.x + randi_range(-50,50)
    var y = screen_size.y / 2 + scroll_offset.y + randi_range(-50,50)

    return Vector2(x,y)