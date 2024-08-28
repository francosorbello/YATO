class_name TodoNode extends GraphNode

enum NodeTypes 
{
    FOLDER,
    COMMENT,
    TASK
}

signal moved(id : String, new_pos : Vector2)
signal node_resized(id : String, new_size : Vector2)

@export var node_type : NodeTypes
var model_id : String

func _ready() -> void:
    self.dragged.connect(_handle_dragged)
    self.resize_end.connect(_handle_resized)

func load(_data : Dictionary):
    pass

func _handle_dragged(_old_pos,new_pos):
    moved.emit(model_id,new_pos)

func _handle_resized(new_size:Vector2):
    node_resized.emit(model_id,new_size)
    pass