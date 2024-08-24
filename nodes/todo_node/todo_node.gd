class_name TodoNode extends GraphNode

enum NodeTypes 
{
    FOLDER,
    COMMENT,
    TASK
}

signal moved(id : String, new_pos : Vector2)

@export var node_type : NodeTypes
var model_id : String

func _ready() -> void:
    self.dragged.connect(_handle_dragged)
    pass

func load(_data : Dictionary):
    pass

func _handle_dragged(_old_pos,new_pos):
    moved.emit(model_id,new_pos)
